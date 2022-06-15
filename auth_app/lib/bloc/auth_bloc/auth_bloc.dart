import 'package:auth_app/model/user.dart';
import 'package:auth_app/service/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationService _auth;

  AuthBloc(this._auth) : super(InitServiceState()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<InitServiceEvent>(_onInitServiceEvent);
    on<ChangePassword>(_onChangePassword);
    on<ChangeUsername>(_onChangeUsername);
    on<Logout>(_onLogout);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter emit) async {
    emit(AuthLoading());
    final bool exists = _auth.authenticateUser(event.username, event.password);
    if (exists) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("signed_in", true);
      prefs.setString("username", event.username);
      prefs.setString("password", event.password);
      emit(LoginSuccess(User(event.username, event.password)));
    } else {
      emit(AuthInitial(error: "User doesn't exist or wrong password"));
    }
  }

  Future<void> _onRegisterEvent(RegisterEvent event, Emitter emit) async {
    emit(AuthLoading());
    final Result result =
        await _auth.createUser(event.username, event.password);
    switch (result) {
      case Result.success:
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("signed_in", true);
        prefs.setString("username", event.username);
        prefs.setString("password", event.password);
        emit(LoginSuccess(User(event.username, event.password)));
        break;
      case Result.failure:
        emit(AuthInitial(error: "Error while registering"));
        break;
      case Result.exists:
        emit(AuthInitial(error: "User already exists"));
        break;
    }
  }

  Future<void> _onInitServiceEvent(InitServiceEvent event, Emitter emit) async {
    emit(AuthLoading());
    await _auth.init();
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool("signed_in") ?? false) {
      String username = prefs.getString("username")!;
      String password = prefs.getString("password")!;

      final bool exists = _auth.authenticateUser(username, password);
      if (exists) {
        emit(LoginSuccess(User(username, password)));
      }
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _onChangePassword(ChangePassword event, Emitter emit) async {
    final state = this.state;
    emit(AuthLoading());
    if (state is LoginSuccess) {
      await _auth.changePassword(state.user.username, event.newPassword);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("password", event.newPassword);
      emit(LoginSuccess(User(state.user.username, event.newPassword)));
    }
  }

  Future<void> _onChangeUsername(ChangeUsername event, Emitter emit) async {
    final state = this.state;
    emit(AuthLoading());
    if (state is LoginSuccess) {
      if (state.user.username.toLowerCase().trim() ==
          event.newUsername.toLowerCase().trim()) {
        emit(LoginSuccess(state.user, error: "Enter different username"));
      } else {
        Result res =
            await _auth.changeUsername(event.newUsername, state.user.username);
        switch (res) {
          case Result.success:
            final prefs = await SharedPreferences.getInstance();
            prefs.setString("username", event.newUsername);
            emit(LoginSuccess(User(event.newUsername, state.user.password)));
            break;
          case Result.failure:
            emit(LoginSuccess(state.user, error: "Something went wrong"));
            break;
          case Result.exists:
            emit(LoginSuccess(state.user, error: "Username taken"));
            break;
        }
      }
    }
  }

  Future<void> _onLogout(Logout event, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    emit(AuthInitial());
  }
}

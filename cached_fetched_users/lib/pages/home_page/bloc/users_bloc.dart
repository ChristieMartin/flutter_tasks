import 'package:bloc/bloc.dart';
import 'package:cached_fetched_users/pages/home_page/utils/get_users.dart';
import 'package:cached_fetched_users/pages/user_page/models/user.dart';


part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersLoading()) {
    on<LoadUsers>(_onLoadUsers);
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter emit) async {
    emit(UsersLoading());
    try {
      emit(UsersLoaded(await getUsers()));
    } catch (e) {
      emit(UsersLoadingFailed(e.toString()));
    }
  }
}

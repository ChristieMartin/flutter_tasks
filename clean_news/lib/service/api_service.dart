import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'newsapi.org';
  static const String _pathAddition = '/v2/';
  static const String _token = 'e65ee0938a2a43ebb15923b48faed18d';

  static void _printGreen(dynamic toPrint) {
    debugPrint('\x1B[32m$toPrint\x1B[0m');
  }

  static void _colorfulResponse(
    String path,
    Map<String, dynamic>? body,
    dynamic res,
  ) {
    _printGreen('-------Request:-------');
    _printGreen('path: $path');
    _printGreen('body: $body');
    debugPrint(res.toString());
    _printGreen('----------------------');
  }

  static Future<dynamic> sendGet(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'X-Api-Key': _token,
    };

    final uri = Uri(
      scheme: 'https',
      host: _baseUrl,
      path: _pathAddition + path,
      queryParameters: queryParameters?.map<String, dynamic>(
          (key, dynamic value) =>
              MapEntry<String, dynamic>(key, value.toString())),
    );

    try {
      final response = await http.get(
        uri,
        headers: headers,
      );

      final dynamic res =
            response.body.isNotEmpty ? json.decode(response.body) : {};

      if (response.statusCode == 200) {

        _colorfulResponse(path, queryParameters, res);
        return res;
      } else {
        if (res is Map) {
          throw res['message'].toString();
        }
        throw 'ERROR: url: $uri \nbody: ${response.body} \nstatusCode: ${response.statusCode}';
      }
    } catch (e) {
      debugPrint('ERROR $uri');
      throw e.toString();
    }
  }

  static Future<dynamic> sendPost(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'X-Api-Key': _token,
    };

    final uri = Uri(
      scheme: 'https',
      host: _baseUrl,
      path: _pathAddition + path,
    );
    try {
      debugPrint('-------Trying:-------');
      debugPrint('uri: $uri');
      debugPrint('body: $body');
      debugPrint('---------------------');
      final http.Response response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final answBody = response.body.replaceFirst(json.encode(body), '');
        final dynamic res =
            response.body.isNotEmpty ? json.decode(answBody) : {};

        _colorfulResponse(path, body, res);
        return res;
      } else {
        throw 'ERROR: url: $uri \nbody: ${response.body} \nstatusCode: ${response.statusCode}';
      }
    } catch (e) {
      debugPrint('ERROR $uri');
      throw e.toString();
    }
  }
}

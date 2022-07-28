import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _host = 'jsonplaceholder.typicode.com';
  static void _printGreen(dynamic toPrint) {
    debugPrint('\x1B[32m$toPrint\x1B[0m');
  }

  static void _colorfulResponse(
      String path, Map<String, dynamic>? body, dynamic res,) {
    _printGreen('-------Request:-------');
    _printGreen('path: $path');
    _printGreen('body: $body');
    debugPrint(res.toString());
    _printGreen('----------------------');
  }

  static Future<dynamic> sendGet(
      String path, {Map<String, dynamic>? queryParameters,}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Accept': '*/*'
    };

    final uri = Uri(
        scheme: 'https',
        host: _host,
        path: path,
        queryParameters: queryParameters?.map<String, dynamic>((key, dynamic value) => MapEntry<String, dynamic>(key, value.toString())),);
    
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final dynamic res =
            response.body.isNotEmpty ? json.decode(response.body) : {};

        _colorfulResponse(path, queryParameters, res);
        return res;
      } else {
        throw 'ERROR: url: $uri \nbody: ${response.body}';
      }
    } catch (e) {
      debugPrint('ERROR $uri');
      throw e.toString();
    }
  }

  static Future<dynamic> sendPost(
      String path, {Map<String, dynamic>? body,}) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Accept': '*/*'
    };

    final uri = Uri(scheme: 'https', host: _host, path: path);
    try {
      debugPrint('-------Trying:-------');
      debugPrint('uri: $uri');
      debugPrint('body: $body');
      debugPrint('---------------------');
      final http.Response response = await http.post(uri,
          body: jsonEncode(body),
          headers: headers,
          encoding: Encoding.getByName('utf-8'),);

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

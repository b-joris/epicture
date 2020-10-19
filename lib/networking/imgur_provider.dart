import 'dart:convert';

import 'package:http/http.dart' as http;

import 'exceptions.dart';

class ImgurProvider {
  final String _baseUrl = 'https://api.imgur.com/3/';

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final data = json.decode(response.body.toString());
        return data;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String> headers,
  }) async {
    final response = await http.get(_baseUrl + endpoint, headers: headers);
    final data = _response(response);
    return data;
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) async {
    final response = await http.post(
      _baseUrl + endpoint,
      headers: headers,
      body: body,
    );
    final data = _response(response);
    return data;
  }
}

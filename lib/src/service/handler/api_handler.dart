import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:iroots/src/service/handler/api_url.dart';

class ApiHandler {
  static Future<http.Response> get({
    required String url,
    required String token,
  }) async {
    debugPrint(url);
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  static Future<http.Response> post({
    required String url,
    required String token,
  }) async {
    debugPrint(url);
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  static Future<http.Response> postBody({
    required String url,
    required String token,
    required Map<String, dynamic> body,
  }) async {

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(body),
    );

    debugPrint("Api Url   ||  $url :: statusCode --> ${response.statusCode} ");
    debugPrint("post data ||  ${body.toString()}");
    debugPrint("Access token ||  ${token}");

    return response;
  }

  static Future<http.Response> put(String url,
      {Map<String, dynamic>? body}) async {
    http.Response response = await http.put(Uri.parse(ApiUrls.baseUrl + url),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    return response;
  }

  static Future<http.Response> delete(String url) async {
    http.Response response = await http.delete(
      Uri.parse(ApiUrls.baseUrl + url),
      // headers: {"Content-Type": "text/html"},
    );

    return response;
  }
}

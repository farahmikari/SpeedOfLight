import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  String baseURL = 'http://192.168.1.14:8000/api';
  String image = 'http://192.168.1.14:8000/storage/images/';

  Future<dynamic> get({
    required String url,
    @required String? token,
  }) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
    }

    http.Response response = await http.get(
      Uri.parse('$baseURL$url'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      print("The code" + response.body);
      dynamic data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      throw Exception(
          'there is a problem with status code with ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> post(
      {required String url,
      @required dynamic body,
      @required String? token,
      @required dynamic header}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        //'Content-Type': 'application/json',
      });
      if (header != null) {
        headers.addAll(header);
      }
    } else if (header != null) {
      headers.addAll(headers);
    }
    //print(body);
    http.Response response = await http.post(
      Uri.parse('$baseURL$url'),
      body: body,
      headers: headers,
    );
    print('url = $baseURL$url ');
    print(response.statusCode);
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);

      //print(data["message"]);

      return data;
    } else {
      throw Exception(
          'there is a problem with status code with ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

enum APISERVICES { post, get }
//base url
const baseUrl = "https://api.stripe.com/v1";
//reuest header
final Map<String, String> requestHeaders = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
};
//pass API request
Future<Map<String, dynamic>?> apiServiceMethod(
    {required APISERVICES apiMethod,
    required String endPoint,
    Map<String, dynamic>? body}) async {
  final String requestUrl = "$baseUrl/$endPoint";
  try {
    final response = apiMethod == APISERVICES.get
        ? await http.get(Uri.parse(requestUrl), headers: requestHeaders)
        : await http.post(Uri.parse(requestUrl),
            headers: requestHeaders, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      debugPrint("Error${response.statusCode}");
      throw Exception('Failed to fetch data: ${response.body}');
    }
  } catch (err) {
    debugPrint("Error: $err");
    return null; // Return n
  }
}

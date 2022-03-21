import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/app_data_model.dart';

String URL = 'https://random-data-api.com/api/users/random_user?size=4';

Future<List<UserInfo>> fetchUsers(http.Client client) async {
  final response = await client.get(Uri.parse(URL));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseOrders, response.body);
}

// A function that converts a response body into a List<Photo>.
List<UserInfo> parseOrders(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<UserInfo>((json) => UserInfo.fromJson(json)).toList();
}

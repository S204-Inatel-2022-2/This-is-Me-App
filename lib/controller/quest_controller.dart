import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:this_is_me/model/character.dart';
import 'package:http/http.dart' as http;
import 'package:this_is_me/model/quest.dart';

Future<List<Quest>> getTodayQuests(http.Client client) async {
  final response = await client.get(
      Uri.parse('https://timeapibyredfoxghs.herokuapp.com/quest/today-cards'),
      headers: {
        'accept': 'application/json',

      });

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseQuests, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Quest> parseQuests(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Quest>((json) => Quest.fromJson(json)).toList();
}

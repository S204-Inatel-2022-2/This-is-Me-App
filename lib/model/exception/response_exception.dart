import 'dart:convert';

class ResponseException {
  final dynamic message;

  ResponseException({required this.message});

  factory ResponseException.fromJson(Map<String, dynamic> json) {
    return ResponseException(message: json['message'].toString());
  }
}

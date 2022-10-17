class ResponseException {
  final String message;

  ResponseException({required this.message});

  factory ResponseException.fromJson(Map<String, dynamic> json) {
    return ResponseException(message: json['message']);
  }
}

class MDLMeta {
  int status;
  String message;
  String authToken;
  bool isVerified;

  MDLMeta({
    required this.status,
    this.message = '',
    this.authToken = '',
    this.isVerified = false,
  });

  factory MDLMeta.fromJson(Map<String, dynamic> json) {
    return MDLMeta(
        status: json['status'],
        message: json['message'] ?? '',
        authToken: json['token'] ?? '',
        isVerified: json['isVerified'] ?? false);
  }
}

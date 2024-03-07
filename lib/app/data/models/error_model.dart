class ErrorResponse {
  const ErrorResponse({required this.code, required this.message, required this.success});

  final int code;
  final String message;
  final bool success;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        code: json['status_code'],
        message: json['status_message'],
        success: json['success'],
      );
}

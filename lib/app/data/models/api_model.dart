class ApiResponse {
  const ApiResponse({required this.code, required this.message, required this.success});

  final int code;
  final String message;
  final bool success;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        code: json['status_code'],
        message: json['status_message'],
        success: json['success'],
      );
}

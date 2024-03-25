import 'package:equatable/equatable.dart';

class LoginData extends Equatable {
  const LoginData({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object?> get props => [username, password];
}

class RequestTokenResponse extends Equatable {
  const RequestTokenResponse({
    required this.success,
    required this.expiredAt,
    required this.requestToken,
  });

  final bool success;
  final String expiredAt;
  final String requestToken;

  factory RequestTokenResponse.fromJson(Map<String, dynamic> json) => RequestTokenResponse(
        success: json['success'],
        expiredAt: json['expires_at'],
        requestToken: json['request_token'],
      );

  @override
  List<Object?> get props => [success, expiredAt, requestToken];
}

class CreateSessionResponse extends Equatable {
  const CreateSessionResponse({required this.success, required this.sessionId});

  final bool success;
  final String sessionId;

  factory CreateSessionResponse.fromJson(Map<String, dynamic> json) => CreateSessionResponse(
        success: json['success'],
        sessionId: json['session_id'],
      );

  @override
  List<Object?> get props => [success, sessionId];
}

class GuestSessionResponse extends Equatable {
  const GuestSessionResponse({
    required this.success,
    required this.guestSessionId,
    required this.expiredAt,
  });

  final bool success;
  final String guestSessionId;
  final String expiredAt;

  factory GuestSessionResponse.fromJson(Map<String, dynamic> json) => GuestSessionResponse(
        success: json['success'],
        guestSessionId: json['guest_session_id'],
        expiredAt: json['expires_at'],
      );

  @override
  List<Object?> get props => [success, guestSessionId, expiredAt];
}

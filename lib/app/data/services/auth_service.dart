import 'package:dio/dio.dart';
import 'package:movie_app/app/data/client/client.dart';

import '../models/auth_model.dart';

class AuthService {
  const AuthService(this.client);

  final Dio client;

  Future<RequestTokenResponse> getRequestToken() async {
    return clientExecutor<RequestTokenResponse>(
      execute: () async {
        final res = await client.get('authentication/token/new');

        return RequestTokenResponse.fromJson(res.data);
      },
    );
  }

  Future<RequestTokenResponse> login(LoginData loginData, String token) async {
    return clientExecutor<RequestTokenResponse>(
      execute: () async {
        final data = {
          "username": loginData.username,
          "password": loginData.password,
          "request_token": token,
        };
        final res = await client.post('authentication/token/validate_with_login', data: data);

        return RequestTokenResponse.fromJson(res.data);
      },
    );
  }

  Future<CreateSessionResponse> createSession(String token) async {
    return clientExecutor<CreateSessionResponse>(
      execute: () async {
        final data = {"request_token": token};
        final res = await client.post('authentication/session/new', data: data);

        return CreateSessionResponse.fromJson(res.data);
      },
    );
  }

  Future<GuestSessionResponse> getGuestSession() async {
    return clientExecutor<GuestSessionResponse>(
      execute: () async {
        final res = await client.get('authentication/guest_session/new');

        return GuestSessionResponse.fromJson(res.data);
      },
    );
  }
}

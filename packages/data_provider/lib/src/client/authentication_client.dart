import 'package:data_provider/data_provider.dart';
import 'package:dio/dio.dart';

/// Authentication client
class AuthenticationClient {
  /// Constructor
  const AuthenticationClient({
    required Http httpClient,
    required TokenStorage tokenStorage,
  })  : _tokenStorage = tokenStorage,
        _http = httpClient;
  final Http _http;
  final TokenStorage _tokenStorage;

  /// Log In endpoints using phone and password
  Future<AuthResponse> logIn({
    required String phone,
    required String password,
    required String? deviceToken,
  }) async {
    final response = await _http.post<dynamic>(
      '/api/riders/auth/login',
      data: {
        'phone': phone,
        'password': password,
        'device_token': deviceToken,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {'requiresToken': 'false'},
      ),
    );

    final data = AuthResponse.fromJson(response.data as Map<String, dynamic>);
    final token = data.data?.accessToken;

    if (token != null) {
      await _tokenStorage.saveToken(token);
    }

    return data;
  }

  /// Log out
  Future<void> logOut({String? deviceToken}) async {
    await _http.post<dynamic>(
      '/api/riders/auth/logout',
      data: {
        'device_token': deviceToken,
      },
    );

    await _tokenStorage.clearToken();
  }
}

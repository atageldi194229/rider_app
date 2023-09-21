import 'package:data_provider/data_provider.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// API response type [Future<Response<dynamic>>] for all responses
typedef ApiResponse = Future<Response<dynamic>>;

/// Dio extended custom Http Client
class Http extends DioForNative {
  /// Construct a new Http
  /// Add all interceptors
  Http({
    required String defaultBaseUrl,
    required TokenProvider tokenProvider,
    required LanguageProvider languageProvider,
  })  : _defaultBaseUrl = defaultBaseUrl,
        super(
          BaseOptions(
            baseUrl: defaultBaseUrl,
            connectTimeout: const Duration(milliseconds: 10000),
            receiveTimeout: const Duration(milliseconds: 10000),
          ),
        ) {
    interceptors.addAll([
      TokenHandleInterceptor(
        tokenProvider: tokenProvider,
      ),
      LanguageInterceptor(
        languageProvider: languageProvider,
      ),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        compact: false,
      ),
    ]);
  }

  /// Default base url
  final String _defaultBaseUrl;

  /// If given value is null default is used
  void updateBaseUrl(String? baseUrl) {
    options.baseUrl = baseUrl ?? _defaultBaseUrl;
  }
}

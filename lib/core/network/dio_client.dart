import 'package:dio/dio.dart';
import '../env/app_config.dart';

class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final qp = Map<String, dynamic>.from(options.queryParameters);
    qp['api_key'] = AppConfig.tmdbApiKey; // inject TMDB key on every call
    options.queryParameters = qp;
    handler.next(options);
  }
}

Dio buildDio() {
  final dio = Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  ));
  dio.interceptors.add(ApiKeyInterceptor());
  return dio;
}

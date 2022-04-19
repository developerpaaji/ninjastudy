import 'package:dio/dio.dart';

class ApiClient with DioMixin {
  final String baseUrl;

  ApiClient({
    required this.baseUrl,
  }) {
    httpClientAdapter = Dio().httpClientAdapter;
    options = BaseOptions(
      baseUrl: baseUrl,
    );
  }

  void addInterceptor(Interceptor interceptor) {
    interceptors.add(interceptor);
  }

  void removeInterceptor(Interceptor interceptor) {
    interceptors.remove(interceptor);
  }
}

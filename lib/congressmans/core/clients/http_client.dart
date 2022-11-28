import 'package:dio/dio.dart';

abstract class HttpClient {
  Future<dynamic> get(String url);
}

class DioClient implements HttpClient {
  final Dio dio;

  DioClient(this.dio);

  @override
  Future<dynamic> get(String url) async {
    return (await dio.get(url)).data;
  }
}

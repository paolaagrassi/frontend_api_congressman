import 'package:dio/dio.dart';

abstract class HttpService {
  Future<dynamic> get(String url);
}

class DioService implements HttpService {
  final Dio dio;

  DioService(this.dio);

  @override
  Future<dynamic> get(String url) async {
    return (await dio.get(url)).data;
  }
}

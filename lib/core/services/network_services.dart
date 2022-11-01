import 'package:dio/dio.dart';

abstract class NetworkServices {
  Future<Response> get(String url);
}

class NetworkServiceImpl extends NetworkServices {
  final Dio dio = Dio();

  @override
  Future<Response> get(String url) async {
    final response = await dio.get(url);
    return response;
  }
}

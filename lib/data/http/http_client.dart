import 'http.dart';

abstract class HttpClient {
  Future<dynamic> request({
    required String url,
    required RequestMethod method,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> body = const {},
    Map<String, dynamic> headers = const {},
  });

  void close();
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

import '../../../data/http/http.dart';
import '../../../infra/http/http.dart';

HttpClient makeDioAdapter() {
  const int timeOutInMilliseconds = 25000;
  final Dio client = Dio(
    BaseOptions(
      followRedirects: true,
      validateStatus: (status) => status != null,
      connectTimeout: const Duration(milliseconds: timeOutInMilliseconds),
      receiveTimeout: const Duration(milliseconds: timeOutInMilliseconds),
      sendTimeout: const Duration(milliseconds: timeOutInMilliseconds),
    ),
  );
  client.interceptors.add(
    PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      canShowLog: kDebugMode,
    ),
  );
  return DioAdapter(client: client);
}

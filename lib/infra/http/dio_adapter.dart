import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../data/errors/errors.dart';
import '../../data/http/http.dart';
import '../../domain/errors/errors.dart';

class DioAdapter implements HttpClient {
  DioAdapter({
    required this.client,
  });

  final Dio client;

  @override
  Future request({
    required String url,
    required RequestMethod method,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> body = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    const Map<String, dynamic> defaultHeaders = {'Content-Type': 'application/json', 'accept': 'application/json'};
    try {
      final response = await _getResponse(
        method: method,
        url: url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers.isNotEmpty ? headers : defaultHeaders,
          receiveDataWhenStatusError: true,
        ),
        body: body,
      );
      return _handleResponse(response);
    } on DioException catch (error) {
      debugPrint(error.toString());
      throw switch (error.type) {
        DioExceptionType.cancel => const UnexpectedError(),
        DioExceptionType.sendTimeout => HttpError.noConnectionError(),
        DioExceptionType.receiveTimeout => HttpError.timeOut(),
        DioExceptionType.badResponse => HttpError.serverError(),
        _ => HttpError.noConnectionError(),
      };
    } on HttpError catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  Future<Response<dynamic>> _getResponse({
    required RequestMethod method,
    required String url,
    Options? options,
    Map<String, dynamic> queryParameters = const {},
    FormData? formData,
    Map<String, dynamic> body = const {},
  }) async =>
      switch (method) {
        RequestMethod.get => client.get(
            url,
            queryParameters: queryParameters,
            options: options,
          ),
        RequestMethod.put => client.put(
            url,
            data: formData ?? body,
            options: options,
          ),
        RequestMethod.post => client.post(
            url,
            data: formData ?? body,
            options: options,
          ),
        RequestMethod.patch => client.patch(
            url,
            data: formData ?? body,
            options: options,
          ),
        RequestMethod.delete => client.delete(
            url,
            queryParameters: queryParameters,
            options: options,
          ),
        _ => client.get(url, queryParameters: queryParameters, options: options),
      };

  dynamic _handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data is Map || response.data is List) {
        return response.data;
      } else {
        return {};
      }
    } else if (response.statusCode == 204) {
      return {};
    } else {
      String message = '';
      String detail = '';
      if (response.data is Map<String, dynamic>) {
        message = (response.data as Map<String, dynamic>)['message'] is String
            ? (response.data as Map<String, dynamic>)['message']
            : '';
        detail = (response.data as Map<String, dynamic>)['detail'] is String
            ? (response.data as Map<String, dynamic>)['detail']
            : '';
      }
      throw switch (response.statusCode) {
        400 => HttpError.badRequest(message: message, detail: detail),
        401 => HttpError.unauthorized(message: message, detail: detail),
        403 => HttpError.forbidden(message: message, detail: detail),
        404 => HttpError.notFound(message: message, detail: detail),
        422 => HttpError.invalidData(message: message, detail: detail),
        429 => HttpError.attemptsExceeded(message: message, detail: detail),
        _ => HttpError.serverError(message: message, detail: detail),
      };
    }
  }

  @override
  void close() => client.close();
}

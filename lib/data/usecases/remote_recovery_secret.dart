import 'package:flutter/widgets.dart';

import '../../domain/errors/errors.dart';
import '../../domain/usecases/usecases.dart';
import '../errors/errors.dart';
import '../http/http.dart';

class RemoteAuthRecoverySecret implements AuthRecoverySecretUsecase {
  const RemoteAuthRecoverySecret({
    required this.httpClient,
    required this.url,
  });

  final HttpClient httpClient;
  final String url;

  @override
  Future<String> call({required AuthRecoverySecretUsecaseParams params}) async {
    try {
      final body = _RemoteLoginParams.fromDomain(params: params).toMap();
      final response = await httpClient.request(
        url: url,
        body: body,
        method: RequestMethod.post,
      );
      if (response is Map && response['totp_secret'] is String) {
        return response['totp_secret'] as String;
      } else {
        throw const InvalidDataError();
      }
    } on HttpError catch (error) {
      debugPrint(error.toString());
      rethrow;
    } on DomainError catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }
}

class _RemoteLoginParams {
  const _RemoteLoginParams({
    required this.username,
    required this.password,
    required this.code,
  });

  final String username;
  final String password;
  final String code;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'username': username,
        'password': password,
        'code': code,
      };

  factory _RemoteLoginParams.fromDomain({required AuthRecoverySecretUsecaseParams params}) => _RemoteLoginParams(
        username: params.username,
        password: params.password,
        code: params.code,
      );
}

import 'package:flutter/widgets.dart';

import '../../domain/errors/errors.dart';
import '../../domain/usecases/usecases.dart';
import '../errors/errors.dart';
import '../http/http.dart';

class RemoteAuthLoginWithTotpCode implements AuthLoginWithTotpCodeUsecase {
  const RemoteAuthLoginWithTotpCode({
    required this.authorizedHttpClient,
    required this.url,
  });

  final HttpClient authorizedHttpClient;
  final String url;

  @override
  Future<void> call({
    required String username,
    required String password,
    required String totpCode,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'username': username,
        'password': password,
        'totp_code': totpCode,
      };
      await authorizedHttpClient.request(
        url: url,
        body: body,
        method: RequestMethod.post,
      );
    } on HttpError catch (error) {
      debugPrint(error.toString());
      rethrow;
    } on DomainError catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }
}

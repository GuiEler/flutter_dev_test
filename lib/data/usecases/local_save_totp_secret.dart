import 'package:flutter/foundation.dart';

import '../../../domain/errors/errors.dart';
import '../../../domain/usecases/usecases.dart';
import '../cache/cache.dart';

class LocalSaveTotpSecret implements SaveTotpSecretUsecase {
  LocalSaveTotpSecret({required this.cacheStorage});

  final CacheStorage cacheStorage;

  @override
  Future<void> call(String totpSecret) async {
    try {
      await cacheStorage.save(
        key: 'totp_secret',
        value: totpSecret,
      );
    } catch (error) {
      debugPrint(error.toString());
      throw const UnexpectedError();
    }
  }
}

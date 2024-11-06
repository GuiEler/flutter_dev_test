import 'package:flutter/foundation.dart';

import '../../../domain/errors/errors.dart';
import '../../../domain/usecases/usecases.dart';
import '../cache/cache.dart';

class LocalLoadTotpSecret implements LoadTotpSecretUsecase {
  LocalLoadTotpSecret({required this.cacheStorage});

  final CacheStorage cacheStorage;

  @override
  Future<String> call() async {
    try {
      final data = await cacheStorage.fetch(key: 'totp_secret');
      return data ?? '';
    } catch (error) {
      debugPrint(error.toString());
      throw const UnexpectedError();
    }
  }
}

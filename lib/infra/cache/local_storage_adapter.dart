import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/cache/cache.dart';

class LocalStorageAdapter implements CacheStorage {
  LocalStorageAdapter({required this.localStorage});

  final FlutterSecureStorage localStorage;

  @override
  Future<void> save({required String key, required dynamic value}) async {
    await localStorage.write(key: key, value: value);
  }

  @override
  Future<void> delete({required String key}) async {
    await localStorage.delete(key: key);
  }

  @override
  Future<String?> fetch({required String key}) async => localStorage.read(key: key);
}

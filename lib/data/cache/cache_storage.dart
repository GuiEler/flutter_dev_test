abstract interface class CacheStorage {
  Future<String?> fetch({required String key});
  Future<void> delete({required String key});
  Future<void> save({
    required String key,
    required String value,
  });
}

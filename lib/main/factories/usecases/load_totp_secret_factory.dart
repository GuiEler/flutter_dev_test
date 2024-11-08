import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../cache/cache.dart';

LoadTotpSecretUsecase makeLocalLoadTotpSecret() => LocalLoadTotpSecret(cacheStorage: makeLocalStorageAdapter());

import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../cache/cache.dart';

SaveTotpSecretUsecase makeLocalSaveTotpSecret() => LocalSaveTotpSecret(cacheStorage: makeLocalStorageAdapter());

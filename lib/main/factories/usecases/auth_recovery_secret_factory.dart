import '../../../data/http/http.dart';
import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../../decorators/decorators.dart';
import '../factories.dart';

AuthRecoverySecretUsecase makeRemoteAuthRecoverySecret({required HttpClient httpClient}) =>
    RemoteAuthRecoverySecretWithLocalSave(
      remoteAuthRecoverySecret: _makeRemoteAuthRecoverySecret(httpClient: httpClient),
      saveTotpSecretUsecase: makeLocalSaveTotpSecret(),
    );

RemoteAuthRecoverySecret _makeRemoteAuthRecoverySecret({required HttpClient httpClient}) => RemoteAuthRecoverySecret(
      httpClient: httpClient,
      url: makeApiUrl('auth/recovery-secret'),
    );

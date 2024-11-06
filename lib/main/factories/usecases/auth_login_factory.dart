import '../../../../data/http/http.dart';
import '../../../../data/usecases/usecases.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../decorators/decorators.dart';
import '../factories.dart';

AuthLoginUsecase makeRemoteAuthLogin({required HttpClient httpClient}) => RemoteAuthLoginWithTotpAuth(
      loadTotpSecretUsecase: makeLocalLoadTotpSecret(),
      generateTotpCodeUsecase: makeLocalGenerateTotpCode(),
      remoteAuthLoginWithTotpCode: makeRemoteAuthLoginWithTotpAuth(httpClient: httpClient),
    );

RemoteAuthLoginWithTotpCode makeRemoteAuthLoginWithTotpAuth({required HttpClient httpClient}) =>
    RemoteAuthLoginWithTotpCode(
      httpClient: httpClient,
      url: makeApiUrl('auth/login'),
    );

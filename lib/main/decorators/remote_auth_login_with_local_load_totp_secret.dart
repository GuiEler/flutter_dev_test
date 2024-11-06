import '../../data/usecases/remote_auth_login_with_totp_code.dart';
import '../../data/usecases/usecases.dart';
import '../../domain/errors/errors.dart';
import '../../domain/usecases/usecases.dart';

class RemoteAuthLoginWithTotpAuth implements AuthLoginUsecase {
  const RemoteAuthLoginWithTotpAuth({
    required this.loadTotpSecretUsecase,
    required this.generateTotpCodeUsecase,
    required this.remoteAuthLoginWithTotpCode,
  });

  final LoadTotpSecretUsecase loadTotpSecretUsecase;
  final GenerateTotpCodeUsecase generateTotpCodeUsecase;
  final RemoteAuthLoginWithTotpCode remoteAuthLoginWithTotpCode;

  @override
  Future<void> call({
    required String username,
    required String password,
  }) async {
    try {
      final totpSecret = await loadTotpSecretUsecase.call();
      if (totpSecret.isEmpty) {
        throw const NoTotpSecretError();
      } else {
        final String totpCode = generateTotpCodeUsecase.call(totpSecret);
        return remoteAuthLoginWithTotpCode.call(
          totpCode: totpCode,
          username: username,
          password: password,
        );
      }
    } on DomainError {
      rethrow;
    }
  }
}

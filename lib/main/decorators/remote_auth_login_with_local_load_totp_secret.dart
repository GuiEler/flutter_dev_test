import '../../data/usecases/local_generate_totp_code.dart';
import '../../data/usecases/remote_auth_login_with_totp_code.dart';
import '../../data/usecases/usecases.dart';
import '../../domain/errors/errors.dart';
import '../../domain/usecases/usecases.dart';

class RemoteAuthLoginWithTotpAuth implements AuthLoginUsecase {
  const RemoteAuthLoginWithTotpAuth({
    required this.loadTotpSecret,
    required this.localGenerateTotpCode,
    required this.remoteAuthLoginWithTotpCode,
  });

  final LocalLoadTotpSecret loadTotpSecret;
  final LocalGenerateTotpCode localGenerateTotpCode;
  final RemoteAuthLoginWithTotpCode remoteAuthLoginWithTotpCode;

  @override
  Future<void> call({
    required String username,
    required String password,
  }) async {
    try {
      final totpSecret = await loadTotpSecret();
      if (totpSecret.isEmpty) {
        throw const NoTotpSecretError();
      } else {
        final String totpCode = localGenerateTotpCode.call(totpSecret);
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

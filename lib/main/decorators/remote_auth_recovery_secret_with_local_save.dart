import '../../data/usecases/usecases.dart';
import '../../domain/usecases/usecases.dart';

class RemoteAuthRecoverySecretWithLocalSave implements AuthRecoverySecretUsecase {
  const RemoteAuthRecoverySecretWithLocalSave({
    required this.remoteAuthRecoverySecret,
    required this.localSaveTotpSecret,
  });

  final RemoteAuthRecoverySecret remoteAuthRecoverySecret;
  final LocalSaveTotpSecret localSaveTotpSecret;

  @override
  Future<void> call({required AuthRecoverySecretUsecaseParams params}) async {
    try {
      final totpSecret = await remoteAuthRecoverySecret.call(params: params);
      await localSaveTotpSecret.call(totpSecret);
    } catch (_) {
      rethrow;
    }
  }
}

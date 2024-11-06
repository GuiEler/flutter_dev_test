import '../../data/usecases/usecases.dart';
import '../../domain/usecases/usecases.dart';

class RemoteAuthRecoverySecretWithLocalSave implements AuthRecoverySecretUsecase {
  const RemoteAuthRecoverySecretWithLocalSave({
    required this.remoteAuthRecoverySecret,
    required this.saveTotpSecretUsecase,
  });

  final RemoteAuthRecoverySecret remoteAuthRecoverySecret;
  final SaveTotpSecretUsecase saveTotpSecretUsecase;

  @override
  Future<void> call({required AuthRecoverySecretUsecaseParams params}) async {
    try {
      final totpSecret = await remoteAuthRecoverySecret.call(params: params);
      await saveTotpSecretUsecase.call(totpSecret);
    } catch (_) {
      rethrow;
    }
  }
}

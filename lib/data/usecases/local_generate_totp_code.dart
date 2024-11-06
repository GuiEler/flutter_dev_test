import 'package:otp/otp.dart';

import '../../domain/errors/errors.dart';
import '../../domain/usecases/usecases.dart';

class LocalGenerateTotpCode implements GenerateTotpCodeUsecase {
  @override
  String call(String secret) {
    try {
      return OTP.generateTOTPCodeString(
        secret,
        DateTime.now().millisecondsSinceEpoch,
        algorithm: Algorithm.SHA1,
        isGoogle: true,
      );
    } catch (error) {
      throw const UnexpectedError();
    }
  }
}

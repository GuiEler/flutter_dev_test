import 'package:equatable/equatable.dart';

abstract interface class AuthRecoverySecretUsecase {
  Future<void> call({required AuthRecoverySecretUsecaseParams params});
}

class AuthRecoverySecretUsecaseParams extends Equatable {
  const AuthRecoverySecretUsecaseParams({
    required this.username,
    required this.password,
    required this.code,
  });

  final String username;
  final String password;
  final String code;

  @override
  List<Object> get props => [
        username,
        password,
        code,
      ];
}

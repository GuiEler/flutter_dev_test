abstract interface class AuthLoginWithTotpCodeUsecase {
  Future<void> call({
    required String username,
    required String password,
    required String totpCode,
  });
}

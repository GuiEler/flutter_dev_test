abstract interface class AuthLoginUsecase {
  Future<void> call({
    required String username,
    required String password,
  });
}

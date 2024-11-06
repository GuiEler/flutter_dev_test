abstract interface class SaveTotpSecretUsecase {
  Future<void> call(String totpSecret);
}

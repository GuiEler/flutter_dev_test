part of 'errors.dart';

class NoTotpSecretError extends DomainError {
  const NoTotpSecretError({super.message = '', super.detail = ''});
}

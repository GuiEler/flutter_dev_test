part of 'errors.dart';

class InvalidCredentialsError extends DomainError {
  const InvalidCredentialsError({super.message = '', super.detail = ''});
}

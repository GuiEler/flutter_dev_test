part of 'errors.dart';

class InvalidEmailError extends DomainError {
  const InvalidEmailError({super.message = '', super.detail = ''});
}

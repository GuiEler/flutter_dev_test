part of 'errors.dart';

class InvalidFieldError extends DomainError {
  const InvalidFieldError({super.message = '', super.detail = ''});
}

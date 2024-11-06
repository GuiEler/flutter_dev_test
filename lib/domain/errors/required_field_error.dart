part of 'errors.dart';

class RequiredFieldError extends DomainError {
  const RequiredFieldError({super.message = '', super.detail = ''});
}

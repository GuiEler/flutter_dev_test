part of 'errors.dart';

class UnexpectedError extends DomainError {
  const UnexpectedError({super.message = '', super.detail = ''});
}

part of 'errors.dart';

class UnauthorizedError extends DomainError {
  const UnauthorizedError({super.message = '', super.detail = ''});
}

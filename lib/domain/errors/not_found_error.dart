part of 'errors.dart';

class NotFoundError extends DomainError {
  const NotFoundError({super.message = '', super.detail = ''});
}

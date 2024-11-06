part of 'errors.dart';

class InvalidDataError extends DomainError {
  const InvalidDataError({super.message = '', super.detail = ''});
}

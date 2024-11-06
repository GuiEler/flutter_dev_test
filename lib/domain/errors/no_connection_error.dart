part of 'errors.dart';

class NoConnectionError extends DomainError {
  const NoConnectionError({super.message = '', super.detail = ''});
}

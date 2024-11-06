part of 'errors.dart';

class NoError extends DomainError {
  const NoError({super.message = '', super.detail = ''});
}

part of 'errors.dart';

class AttemptsExceededError extends DomainError {
  AttemptsExceededError({super.message = '', super.detail = ''});
}

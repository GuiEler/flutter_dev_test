part of 'errors.dart';

class ApiError extends DomainError {
  ApiError({super.message = '', super.detail = ''});
}

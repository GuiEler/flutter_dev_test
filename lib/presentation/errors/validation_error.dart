import '../../domain/errors/errors.dart';

sealed class ValidationError implements Exception {
  const ValidationError._({this.message = '', this.detail = ''});

  final String message;
  final String detail;

  factory ValidationError.noError({String message = ''}) => _NoError(message: message);
  factory ValidationError.requiredField({String message = ''}) => _RequiredField(message: message);
  factory ValidationError.invalidField({String message = ''}) => _InvalidField(message: message);
  factory ValidationError.minimumLength({String message = ''}) => _MinimumLength(message: message);
  factory ValidationError.invalidCpf({String message = ''}) => _InvalidCpf(message: message);
  factory ValidationError.invalidCpfOrEmail({String message = ''}) => _InvalidCpfOfEmail(message: message);
  factory ValidationError.invalidEmail({String message = ''}) => _InvalidEmail(message: message);
}

final class _NoError extends ValidationError implements NoError {
  const _NoError({super.message}) : super._();
}

final class _RequiredField extends ValidationError implements RequiredFieldError {
  const _RequiredField({super.message}) : super._();
}

final class _InvalidField extends ValidationError implements InvalidFieldError {
  const _InvalidField({super.message}) : super._();
}

final class _MinimumLength extends ValidationError implements InvalidFieldError {
  const _MinimumLength({super.message}) : super._();
}

final class _InvalidCpf extends ValidationError implements InvalidFieldError {
  const _InvalidCpf({super.message}) : super._();
}

final class _InvalidCpfOfEmail extends ValidationError implements InvalidFieldError {
  const _InvalidCpfOfEmail({super.message}) : super._();
}

final class _InvalidEmail extends ValidationError implements InvalidEmailError {
  const _InvalidEmail({super.message}) : super._();
}

extension ConvertToDomainError on ValidationError {
  /// Convert ValidationError to DomainError equivalent
  DomainError toDomainError() => switch (runtimeType) {
        const (_NoError) => const NoError(),
        const (_RequiredField) => const RequiredFieldError(),
        const (_InvalidField) => const InvalidFieldError(),
        const (_MinimumLength) => const InvalidFieldError(),
        const (_InvalidCpf) => const InvalidFieldError(),
        const (_InvalidCpfOfEmail) => const InvalidFieldError(),
        const (_InvalidEmail) => const InvalidEmailError(),
        _ => const UnexpectedError(),
      };
}

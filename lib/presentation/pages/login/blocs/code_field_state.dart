part of 'code_field_cubit.dart';

sealed class CodeFieldState {
  const CodeFieldState({
    required this.code,
    required this.codeErrorText,
    required this.isFormValid,
  });
  final String code;
  final String? codeErrorText;
  final bool isFormValid;
}

final class CodeFieldInitialState extends CodeFieldState {
  const CodeFieldInitialState() : super(code: '', codeErrorText: '', isFormValid: false);
}

final class CodeFieldValidatingState extends CodeFieldState {
  CodeFieldValidatingState({
    required super.code,
    required super.codeErrorText,
    required super.isFormValid,
  });
}

part of 'login_form_cubit.dart';

sealed class LoginFormState {
  const LoginFormState({
    required this.email,
    this.emailErrorText,
    required this.password,
    required this.passwordErrorText,
    required this.isFormValid,
  });
  final String email;
  final String? emailErrorText;
  final String password;
  final String? passwordErrorText;
  final bool isFormValid;
}

final class LoginFormInitialState extends LoginFormState {
  const LoginFormInitialState()
      : super(
          email: '',
          emailErrorText: null,
          password: '',
          passwordErrorText: null,
          isFormValid: false,
        );
}

final class LoginFormValidatingEmailState extends LoginFormState {
  LoginFormValidatingEmailState({
    required super.email,
    required super.emailErrorText,
    required super.password,
    required super.passwordErrorText,
    required super.isFormValid,
  });
}

final class LoginFormValidatingPasswordState extends LoginFormState {
  LoginFormValidatingPasswordState({
    required super.email,
    required super.emailErrorText,
    required super.password,
    required super.passwordErrorText,
    required super.isFormValid,
  });
}

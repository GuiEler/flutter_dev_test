part of 'login_form_cubit.dart';

sealed class LoginFormState {
  const LoginFormState({
    required this.username,
    this.usernameErrorText,
    required this.password,
    required this.passwordErrorText,
    required this.isFormValid,
  });
  final String username;
  final String? usernameErrorText;
  final String password;
  final String? passwordErrorText;
  final bool isFormValid;
}

final class LoginFormInitialState extends LoginFormState {
  const LoginFormInitialState()
      : super(
          username: '',
          usernameErrorText: null,
          password: '',
          passwordErrorText: null,
          isFormValid: false,
        );
}

final class LoginFormValidatingUsernameState extends LoginFormState {
  LoginFormValidatingUsernameState({
    required super.username,
    required super.usernameErrorText,
    required super.password,
    required super.passwordErrorText,
    required super.isFormValid,
  });
}

final class LoginFormValidatingPasswordState extends LoginFormState {
  LoginFormValidatingPasswordState({
    required super.username,
    required super.usernameErrorText,
    required super.password,
    required super.passwordErrorText,
    required super.isFormValid,
  });
}

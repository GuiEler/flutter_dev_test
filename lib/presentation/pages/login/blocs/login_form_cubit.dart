import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/errors/errors.dart';
import '../../../errors/errors.dart';
import '../../../protocols/protocols.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit({
    required Validation validation,
  })  : _validation = validation,
        super(const LoginFormInitialState());

  final Validation _validation;

  String _username = '';
  String _password = '';
  UIError _validateField(String field) {
    final formData = {
      'username': _username,
      'password': _password,
    };
    final error = _validation.validate(field: field, input: formData);
    return error.toDomainError().toUIError();
  }

  void validateUsername(String username) {
    _username = username;
    final error = _validateField('username');
    final String? usernameErrorText = error is NoError ? null : error.message;
    emit(
      LoginFormValidatingUsernameState(
        username: username,
        password: state.password,
        usernameErrorText: usernameErrorText,
        passwordErrorText: state.passwordErrorText,
        isFormValid: username.isNotEmpty &&
            usernameErrorText == null &&
            state.password.isNotEmpty &&
            state.passwordErrorText == null,
      ),
    );
  }

  void validatePassword(String password) {
    _password = password;
    final error = _validateField('password');
    final String? passwordErrorText = error is NoError ? null : error.message;
    emit(
      LoginFormValidatingPasswordState(
        username: state.username,
        password: password,
        usernameErrorText: state.usernameErrorText,
        passwordErrorText: passwordErrorText,
        isFormValid: password.isNotEmpty &&
            passwordErrorText == null &&
            state.username.isNotEmpty &&
            state.usernameErrorText == null,
      ),
    );
  }
}

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

  String _email = '';
  String _password = '';
  UIError _validateField(String field) {
    final formData = {
      'email': _email,
      'password': _password,
    };
    final error = _validation.validate(field: field, input: formData);
    return error.toDomainError().toUIError();
  }

  void validateEmail(String email) {
    _email = email;
    final error = _validateField('email');
    final String? emailErrorText = error is NoError ? null : error.message;
    emit(
      LoginFormValidatingEmailState(
        email: email,
        password: state.password,
        emailErrorText: emailErrorText,
        passwordErrorText: state.passwordErrorText,
        isFormValid:
            email.isNotEmpty && emailErrorText == null && state.password.isNotEmpty && state.passwordErrorText == null,
      ),
    );
  }

  void validatePassword(String password) {
    _password = password;
    final error = _validateField('password');
    final String? passwordErrorText = error is NoError ? null : error.message;
    emit(
      LoginFormValidatingPasswordState(
        email: state.email,
        password: password,
        emailErrorText: state.emailErrorText,
        passwordErrorText: passwordErrorText,
        isFormValid:
            password.isNotEmpty && passwordErrorText == null && state.email.isNotEmpty && state.emailErrorText == null,
      ),
    );
  }
}

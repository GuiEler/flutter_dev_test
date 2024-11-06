import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/errors/errors.dart';
import '../../../protocols/protocols.dart';

part 'code_field_state.dart';

class CodeFieldCubit extends Cubit<CodeFieldState> {
  CodeFieldCubit({required Validation validation})
      : _validation = validation,
        super(const CodeFieldInitialState());

  final Validation _validation;

  void validateCode(String code) {
    final error = _validation.validate(field: 'code', input: {'code': code});
    final String? codeErrorText = error is NoError ? null : error.message;
    emit(
      CodeFieldValidatingState(
        code: code,
        codeErrorText: codeErrorText,
        isFormValid: code.isNotEmpty && codeErrorText == null,
      ),
    );
  }
}

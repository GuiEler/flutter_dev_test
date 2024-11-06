import 'package:equatable/equatable.dart';

import '../../presentation/errors/errors.dart';
import '../protocols/protocols.dart';

class EmailValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const EmailValidation(this.field);

  @override
  ValidationError validate(Map input) {
    if (input[field] is String) {
      final regex = RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+$');
      final isValid = (input[field] as String).isNotEmpty != true || regex.hasMatch(input[field] as String);
      return isValid ? ValidationError.noError() : ValidationError.invalidEmail();
    } else {
      return ValidationError.invalidEmail();
    }
  }
}

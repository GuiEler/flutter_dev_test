import 'package:equatable/equatable.dart';

import '../../presentation/errors/errors.dart';
import '../protocols/protocols.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const RequiredFieldValidation(this.field);

  @override
  ValidationError validate(Map input) {
    if (input[field] is String) {
      return (input[field] as String).isNotEmpty == true ? ValidationError.noError() : ValidationError.requiredField();
    } else {
      return ValidationError.invalidField();
    }
  }
}

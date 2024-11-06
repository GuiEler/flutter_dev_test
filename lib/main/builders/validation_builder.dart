import '../../validation/protocols/protocols.dart';
import '../../validation/validators/validators.dart';

class ValidationBuilder {
  final List<FieldValidation> _fieldValidations = [];
  final String fieldName;
  ValidationBuilder._(this.fieldName);

  factory ValidationBuilder.field(String fieldName) => ValidationBuilder._(fieldName);

  ValidationBuilder required() {
    _fieldValidations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidationBuilder email() {
    _fieldValidations.add(EmailValidation(fieldName));
    return this;
  }

  ValidationBuilder min(int size) {
    _fieldValidations.add(MinLengthValidation(field: fieldName, size: size));
    return this;
  }

  List<FieldValidation> build() => _fieldValidations;
}

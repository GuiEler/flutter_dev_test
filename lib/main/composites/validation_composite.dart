import '../../domain/errors/errors.dart';
import '../../presentation/errors/errors.dart';
import '../../presentation/protocols/protocols.dart';
import '../../validation/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  ValidationError validate({required String field, required Map input}) {
    ValidationError error = ValidationError.noError();
    for (final validation in validations.where((validation) => validation.field == field)) {
      error = validation.validate(input);
      if (error is! NoError) {
        return error;
      }
    }
    return error;
  }
}

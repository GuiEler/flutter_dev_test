import '../errors/errors.dart';

abstract class Validation {
  ValidationError validate({required String field, required Map input});
}

import 'package:equatable/equatable.dart';

import '../../presentation/errors/errors.dart';
import '../protocols/protocols.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  const MinLengthValidation({
    required this.field,
    required this.size,
  });

  @override
  final String field;
  final int size;

  @override
  List get props => [field, size];

  @override
  ValidationError validate(Map input) {
    if (input[field] is String) {
      final String text = input[field] as String;
      final RegExp emojiRegex = RegExp(
        '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
      );
      final List<Match> matches = emojiRegex.allMatches(text).toList();
      int emojisLength = 0;
      for (int i = 0; i < matches.length; i++) {
        emojisLength += matches[i].group(0)?.length ?? 0;
      }
      final int fieldLength = text.length - emojisLength + matches.length;
      return fieldLength >= size ? ValidationError.noError() : ValidationError.invalidField();
    } else {
      return ValidationError.invalidField();
    }
  }
}

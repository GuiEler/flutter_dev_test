import 'package:flutter/services.dart';

mixin KeyboardManager {
  void hideKeyboard() => SystemChannels.textInput.invokeMethod('TextInput.hide');
}

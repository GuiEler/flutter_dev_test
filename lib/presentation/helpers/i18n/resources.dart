import 'package:flutter/widgets.dart';

import './strings/strings.dart';

mixin R {
  static Translations strings = PtBr();

  static void load(Locale locale) {
    switch (locale.toString()) {
      default:
        strings = PtBr();
        break;
    }
  }
}

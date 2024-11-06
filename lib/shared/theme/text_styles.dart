import 'package:flutter/widgets.dart';

import 'theme.dart';

mixin TextStyles {
  static const FontWeight _regular = FontWeight.w500;
  static const FontWeight _semibold = FontWeight.w600;

  /// [fontSize]: 20, [fontWeight]: 600
  static const TextStyle heading = TextStyle(
    fontSize: 20,
    height: 1.6,
    fontWeight: _semibold,
    color: GlobalColors.primary,
    fontFamily: 'PlusJakartaSans',
    decoration: TextDecoration.none,
  );

  /// [fontSize]: 14, [fontWeight]: 500
  static const TextStyle subheading = TextStyle(
    fontSize: 14,
    fontWeight: _regular,
    color: GlobalColors.primary,
    height: 1.43,
    fontFamily: 'PlusJakartaSans',
    decoration: TextDecoration.none,
  );

  /// [fontSize]: 13, [fontWeight]: 600
  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: _semibold,
    color: GlobalColors.primary,
    height: 1.5,
    fontFamily: 'PlusJakartaSans',
    decoration: TextDecoration.none,
  );

  /// [fontSize]: 12, [fontWeight]: 500
  static const TextStyle callout = TextStyle(
    fontSize: 12,
    fontWeight: _regular,
    color: GlobalColors.primary,
    height: 1.67,
    fontFamily: 'PlusJakartaSans',
    decoration: TextDecoration.none,
  );
}

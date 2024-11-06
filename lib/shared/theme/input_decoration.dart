import 'package:flutter/material.dart';

import '../theme/theme.dart';

InputDecoration getInputDecoration({
  bool? alignLabelWithHint,
  String? labelText,
  String? errorText,
  Widget? suffixIcon,
  Widget? counter,
  String? counterText,
  TextStyle? counterStyle,
  FloatingLabelBehavior? floatingLabelBehavior,
  String? hintText,
}) =>
    InputDecoration(
      alignLabelWithHint: alignLabelWithHint,
      labelText: labelText,
      filled: true,
      fillColor: GlobalColors.surface,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      labelStyle: WidgetStateTextStyle.resolveWith(
        (_) => TextStyles.callout.copyWith(
          color: GlobalColors.onBackground,
        ),
      ),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith(
        (_) => TextStyles.callout.copyWith(
          color: GlobalColors.onBackground,
          fontWeight: FontWeight.w700,
        ),
      ),
      hintMaxLines: 1,
      errorStyle: WidgetStateTextStyle.resolveWith(
        (_) => const TextStyle(color: GlobalColors.error, fontWeight: FontWeight.w600),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      errorText: errorText,
      suffixIcon: suffixIcon,
      counter: counter,
      counterText: counterText,
      counterStyle: counterStyle,
      floatingLabelBehavior: floatingLabelBehavior,
      hintText: hintText,
    );

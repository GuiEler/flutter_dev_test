import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../shared/theme/theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.autofocus = false,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.errorText,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    this.autofillHints,
    this.inputFormatters,
    this.focusNode,
    this.validateSubmission = true,
    this.onSubmitted,
    this.textInputAction,
    this.readOnly = false,
    this.autocorrect = true,
    this.textCapitalization = TextCapitalization.none,
  });

  final bool autofocus;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool validateSubmission;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final bool autocorrect;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) => TextField(
        autofocus: autofocus,
        focusNode: focusNode,
        decoration: getInputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          suffixIcon: suffixIcon,
        ),
        cursorColor: GlobalColors.primary,
        cursorRadius: const Radius.circular(4),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        autofillHints: autofillHints,
        inputFormatters: inputFormatters,
        onSubmitted: validateSubmission
            ? (value) {
                if (value.isNotEmpty && errorText == null) {
                  onSubmitted?.call(value);
                }
              }
            : onSubmitted,
        textInputAction: textInputAction,
        readOnly: readOnly,
        autocorrect: autocorrect,
        textCapitalization: textCapitalization,
      );
}

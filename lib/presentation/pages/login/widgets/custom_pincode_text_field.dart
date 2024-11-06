import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../shared/theme/theme.dart';

part 'pin_code_text_field.dart';

class CustomPinCodeTextField extends StatefulWidget {
  const CustomPinCodeTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.onCompleted,
    this.onSubmitted,
    this.autoFocus = false,
    this.fieldValidatedColor,
    this.onChanged,
    required this.fieldWidth,
    required this.fieldsCount,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onCompleted;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool autoFocus;
  final Color? fieldValidatedColor;
  final double fieldWidth;
  final int fieldsCount;

  @override
  State<CustomPinCodeTextField> createState() => _CustomPinCodeTextFieldState();
}

class _CustomPinCodeTextFieldState extends State<CustomPinCodeTextField> {
  @override
  Widget build(BuildContext context) => Focus(
        onFocusChange: (value) {
          if (value) {
            Future.delayed(
              const Duration(milliseconds: 200),
              () {
                if (context.mounted) {
                  Scrollable.ensureVisible(context, duration: const Duration(milliseconds: 200));
                }
              },
            );
          }
        },
        child: PinCodeTextField(
          textStyle: TextStyles.heading,
          appContext: context,
          length: widget.fieldsCount,
          enablePinAutofill: false,
          controller: widget.controller,
          beforeTextPaste: (text) => false,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          pinTheme: PinTheme(
            fieldHeight: widget.fieldWidth,
            fieldWidth: widget.fieldWidth,
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
          ),
          autoDismissKeyboard: false,
          autoFocus: widget.autoFocus,
          onCompleted: (_) {
            widget.onCompleted?.call();
          },
          onChanged: widget.onChanged,
          cursorColor: GlobalColors.primary,
          enableActiveFill: true,
          animationType: AnimationType.fade,
          focusNode: widget.focusNode,
          onSubmitted: (value) => widget.onSubmitted?.call(value),
        ),
      );
}

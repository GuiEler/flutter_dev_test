import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/theme/theme.dart';
import '../../../helpers/i18n/i18n.dart';
import '../blocs/login_form_cubit.dart';
import 'widgets.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.validatePassword,
    required this.focusNode,
    required this.onSubmitted,
  });

  final void Function(String) validatePassword;
  final FocusNode focusNode;
  final void Function(LoginFormState state) onSubmitted;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late final TextEditingController controller = TextEditingController();
  bool hideText = true;

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginFormCubit, LoginFormState>(
        buildWhen: (previous, current) => current is LoginFormValidatingPasswordState,
        builder: (context, state) => CustomTextField(
          focusNode: widget.focusNode,
          labelText: R.strings.password,
          onChanged: widget.validatePassword,
          errorText: state.passwordErrorText,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.go,
          controller: controller,
          obscureText: hideText,
          onSubmitted: state.isFormValid ? (_) => widget.onSubmitted(state) : null,
          suffixIcon: controller.text.isNotEmpty
              ? Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(hideText ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    onPressed: () => setState(() => hideText = !hideText),
                    color: GlobalColors.primary,
                    splashRadius: 16,
                  ),
                )
              : null,
        ),
      );
}

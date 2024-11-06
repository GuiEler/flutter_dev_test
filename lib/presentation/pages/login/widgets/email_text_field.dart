import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/theme/theme.dart';
import '../../../helpers/i18n/i18n.dart';
import '../blocs/login_form_cubit.dart';
import 'widgets.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    super.key,
    required this.validateEmail,
    required this.passwordFocusNode,
  });

  final void Function(String) validateEmail;
  final FocusNode passwordFocusNode;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  late final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginFormCubit, LoginFormState>(
        buildWhen: (previous, current) => current is LoginFormValidatingEmailState,
        builder: (context, state) => CustomTextField(
          labelText: R.strings.email,
          onChanged: widget.validateEmail,
          errorText: state.emailErrorText,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          controller: controller,
          onSubmitted: controller.text.isNotEmpty && state.emailErrorText == null
              ? (_) => widget.passwordFocusNode.requestFocus()
              : null,
          suffixIcon: controller.text.isNotEmpty
              ? Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 16,
                    ),
                    onPressed: () {
                      controller.clear();
                      widget.validateEmail('');
                    },
                    color: GlobalColors.primary,
                    splashRadius: 16,
                  ),
                )
              : null,
        ),
      );
}

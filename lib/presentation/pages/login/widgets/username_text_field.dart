import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/theme/theme.dart';
import '../../../helpers/i18n/i18n.dart';
import '../blocs/login_form_cubit.dart';
import 'widgets.dart';

class UsernameTextField extends StatefulWidget {
  const UsernameTextField({
    super.key,
    required this.validateUsername,
    required this.passwordFocusNode,
  });

  final void Function(String) validateUsername;
  final FocusNode passwordFocusNode;

  @override
  State<UsernameTextField> createState() => _UsernameTextFieldState();
}

class _UsernameTextFieldState extends State<UsernameTextField> {
  late final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginFormCubit, LoginFormState>(
        buildWhen: (previous, current) => current is LoginFormValidatingUsernameState,
        builder: (context, state) => CustomTextField(
          labelText: R.strings.username,
          onChanged: widget.validateUsername,
          errorText: state.usernameErrorText,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          controller: controller,
          onSubmitted: controller.text.isNotEmpty && state.usernameErrorText == null
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
                      widget.validateUsername('');
                    },
                    color: GlobalColors.primary,
                    splashRadius: 16,
                  ),
                )
              : null,
        ),
      );
}

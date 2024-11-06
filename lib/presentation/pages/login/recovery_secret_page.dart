import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:lottie/lottie.dart';

import '../../../assets/lotties/app_lotties.dart';
import '../../../shared/snackbar/show_main_error_message.dart';
import '../../../shared/theme/theme.dart';
import '../../helpers/i18n/i18n.dart';
import '../../mixins/mixins.dart';
import 'blocs/code_field_cubit.dart';
import 'blocs/recovery_secret_cubit.dart';
import 'widgets/custom_pincode_text_field.dart';

class RecoverySecretPage extends StatefulWidget {
  const RecoverySecretPage({super.key});

  @override
  State<RecoverySecretPage> createState() => _RecoverySecretPageState();
}

class _RecoverySecretPageState extends State<RecoverySecretPage> with KeyboardManager {
  late final double screenWidth = MediaQuery.sizeOf(context).width;
  late final double logoPadding = screenWidth * 0.2;
  static const int fieldsCount = 6;
  static const int fieldPadding = 8;
  static const contentPadding = EdgeInsets.symmetric(horizontal: 20);
  late final double fieldWidth =
      ((screenWidth - contentPadding.horizontal) - (fieldPadding * fieldsCount - 1)) / fieldsCount;
  late final _recoverySecretCubit = context.read<RecoverySecretCubit>();
  late final _codeFieldCubit = context.read<CodeFieldCubit>();

  @override
  Widget build(BuildContext context) => BlocListener<RecoverySecretCubit, RecoverySecretState>(
        listener: (context, state) => switch (state) {
          RecoverySecretMainErrorState() => showMainErrorMessage(errorMessage: state.error.message),
          RecoverySecretNavigateState() => state.navigate(context),
          _ => {}
        },
        child: GestureDetector(
          onTap: hideKeyboard,
          child: Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            R.strings.verification,
                            style: TextStyles.heading,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4, bottom: logoPadding),
                            child: Text(
                              R.strings.insertTheSendedCode,
                              style: TextStyles.subheading.copyWith(color: GlobalColors.secondary),
                            ),
                          ),
                          CustomPinCodeTextField(
                            fieldWidth: fieldWidth,
                            fieldsCount: fieldsCount,
                            onChanged: _codeFieldCubit.validateCode,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 24),
                            child: BlocBuilder<RecoverySecretCubit, RecoverySecretState>(
                              builder: (context, recoverySecretState) => BlocBuilder<CodeFieldCubit, CodeFieldState>(
                                builder: (context, codeFieldState) => ElevatedButton(
                                  onPressed: codeFieldState.isFormValid
                                      ? () => _recoverySecretCubit.recoverySecret(code: codeFieldState.code)
                                      : null,
                                  child: recoverySecretState is RecoverySecretLoadingState
                                      ? SizedBox(
                                          height: 24,
                                          child: LottieBuilder.asset(
                                            AppLotties.loading,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      : Text(R.strings.confirm),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(
                                      IconsaxPlusLinear.message_question,
                                      color: GlobalColors.brown,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      R.strings.doNotReceivedTheCode,
                                      style: TextStyles.label.copyWith(color: GlobalColors.onBackground),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../assets/images/app_images.dart';
import '../../../assets/lotties/app_lotties.dart';
import '../../../assets/svgs/app_svgs.dart';
import '../../../shared/snackbar/show_main_error_message.dart';
import '../../../shared/theme/theme.dart';
import '../../helpers/i18n/i18n.dart';
import '../../mixins/mixins.dart';
import 'blocs/login_cubit.dart';
import 'blocs/login_form_cubit.dart';
import 'widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with KeyboardManager {
  late final double screenWidth = MediaQuery.sizeOf(context).width;
  late final double logoWidth = screenWidth * 0.6;
  late final double logoPadding = screenWidth * 0.2;
  static const Duration animationDuration = Duration(milliseconds: 400);
  static const Duration animationDelay = Duration(milliseconds: 200);
  late final _loginCubit = context.read<LoginCubit>();
  late final _loginFormCubit = context.read<LoginFormCubit>();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _loginCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<LoginCubit, LoginState>(
        listener: (context, state) => switch (state) {
          LoginMainErrorState() => showMainErrorMessage(errorMessage: state.error.message),
          LoginNavigateState() => state.navigate(context),
          _ => {}
        },
        child: GestureDetector(
          onTap: hideKeyboard,
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverList.list(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: logoPadding, bottom: logoPadding / 2),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned.fill(
                              bottom: logoWidth * 0.32,
                              child: FadeIn(
                                delay: animationDelay,
                                duration: animationDuration,
                                child: SvgPicture.asset(
                                  AppSvgs.wave2,
                                  fit: BoxFit.fitWidth,
                                  width: screenWidth * 1.52,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              top: logoWidth * 0.4,
                              child: FadeIn(
                                delay: animationDelay,
                                duration: animationDuration,
                                child: SvgPicture.asset(
                                  AppSvgs.wave1,
                                  fit: BoxFit.fitWidth,
                                  width: screenWidth * 1.4,
                                ),
                              ),
                            ),
                            Image.asset(
                              AppImages.logo,
                              width: logoWidth,
                              height: logoWidth,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            UsernameTextField(
                              validateUsername: _loginFormCubit.validateUsername,
                              passwordFocusNode: passwordFocusNode,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 20),
                              child: PasswordTextField(
                                onSubmitted: (state) => _loginCubit.login(
                                  username: state.username,
                                  password: state.password,
                                ),
                                validatePassword: _loginFormCubit.validatePassword,
                                focusNode: passwordFocusNode,
                              ),
                            ),
                            BlocBuilder<LoginCubit, LoginState>(
                              builder: (context, loginState) => BlocBuilder<LoginFormCubit, LoginFormState>(
                                builder: (context, loginFormState) => ElevatedButton(
                                  onPressed: loginFormState.isFormValid
                                      ? () => _loginCubit.login(
                                            username: loginFormState.username,
                                            password: loginFormState.password,
                                          )
                                      : null,
                                  child: loginState is LoginLoadingState
                                      ? SizedBox(
                                          height: 24,
                                          child: LottieBuilder.asset(
                                            AppLotties.loading,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      : Text(R.strings.enter),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {},
                          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              R.strings.forgotPassword,
                              style: TextStyles.label.copyWith(color: GlobalColors.brown),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

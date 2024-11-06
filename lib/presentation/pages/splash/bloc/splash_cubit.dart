import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../main/routes.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitialState());

  void goToLoginPage() =>
      emit(SplashNavigateState(navigate: (context) => context.pushReplacement(AppRoutes.login.path)));
}

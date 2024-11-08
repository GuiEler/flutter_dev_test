import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/errors/errors.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../../../main/routes.dart';
import '../../../errors/errors.dart';
import '../../../helpers/i18n/i18n.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required AuthLoginUsecase authLoginUsecase, required void Function() onClose})
      : _onClose = onClose,
        _authLoginUsecase = authLoginUsecase,
        super(const LoginInitialState());

  final AuthLoginUsecase _authLoginUsecase;
  final VoidCallback _onClose;

  Future<void> login({required String username, required String password}) async {
    try {
      await _authLoginUsecase.call(username: username, password: password);
      emit(LoginNavigateState(navigate: (context) => context.pushReplacement(AppRoutes.home.path)));
    } on DomainError catch (error) {
      if (error is NoTotpSecretError) {
        emit(
          LoginNavigateState(
            navigate: (context) => context.push(
              AppRoutes.recoverySecret.path,
              extra: {
                'username': username,
                'password': password,
              },
            ),
          ),
        );
      } else if (error is UnauthorizedError) {
        emit(LoginMainErrorState(error: error.toUIError(customMessage: R.strings.invalidCredentialsError)));
      } else {
        emit(LoginMainErrorState(error: error.toUIError()));
      }
    }
  }

  @override
  Future<void> close() async {
    _onClose();
    super.close();
  }
}

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/errors/errors.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../../errors/errors.dart';

part 'recovery_secret_state.dart';

class RecoverySecretCubit extends Cubit<RecoverySecretState> {
  RecoverySecretCubit(
    super.initialState, {
    required void Function() onClose,
    required AuthRecoverySecretUsecase authRecoverySecretUsecase,
  })  : _authRecoverySecretUsecase = authRecoverySecretUsecase,
        _onClose = onClose {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (state is RecoverySecretInitialState) {
        final RecoverySecretInitialState initialState = state as RecoverySecretInitialState;
        if (initialState.extra is Map &&
            (initialState.extra! as Map)['username'] is String &&
            (initialState.extra! as Map)['password'] is String) {
          _username = (initialState.extra! as Map)['username'];
          _password = (initialState.extra! as Map)['password'];
        } else {
          emit(
            RecoverySecretNavigateState(
              navigate: (context) => context.pop(),
            ),
          );
        }
      }
    });
  }

  final VoidCallback _onClose;
  final AuthRecoverySecretUsecase _authRecoverySecretUsecase;

  String _username = '';
  String _password = '';

  @override
  Future<void> close() async {
    _onClose();
    super.close();
  }

  Future<void> recoverySecret({required String code}) async {
    try {
      emit(const RecoverySecretLoadingState());
      await Future.delayed(const Duration(seconds: 2));
      await _authRecoverySecretUsecase.call(
        params: AuthRecoverySecretUsecaseParams(
          username: _username,
          password: _password,
          code: code,
        ),
      );
      emit(
        RecoverySecretNavigateState(
          navigate: (context) => context.pop(),
        ),
      );
    } on DomainError catch (error) {
      emit(RecoverySecretMainErrorState(error: error.toUIError(useStandartMessage: false)));
    }
  }
}

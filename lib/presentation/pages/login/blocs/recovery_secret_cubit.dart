import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../errors/errors.dart';

part 'recovery_secret_state.dart';

class RecoverySecretCubit extends Cubit<RecoverySecretState> {
  RecoverySecretCubit({required void Function() onClose})
      : _onClose = onClose,
        super(const RecoverySecretInitialState());

  final VoidCallback _onClose;

  @override
  Future<void> close() async {
    _onClose();
    super.close();
  }
}

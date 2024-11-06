part of 'recovery_secret_cubit.dart';

sealed class RecoverySecretState {
  const RecoverySecretState();
}

final class RecoverySecretInitialState extends RecoverySecretState {
  const RecoverySecretInitialState({required this.extra});
  final Object? extra;
}

final class RecoverySecretLoadingState extends RecoverySecretState {
  const RecoverySecretLoadingState();
}

final class RecoverySecretMainErrorState extends RecoverySecretState {
  const RecoverySecretMainErrorState({required this.error});
  final UIError error;
}

final class RecoverySecretNavigateState extends RecoverySecretState {
  const RecoverySecretNavigateState({required this.navigate});
  final void Function(BuildContext context) navigate;
}

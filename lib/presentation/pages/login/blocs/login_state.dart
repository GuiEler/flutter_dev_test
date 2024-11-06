part of 'login_cubit.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginInitialState extends LoginState {
  const LoginInitialState();
}

final class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

final class LoginMainErrorState extends LoginState {
  const LoginMainErrorState({required this.error});
  final UIError error;
}

final class LoginNavigateState extends LoginState {
  const LoginNavigateState({required this.navigate});
  final void Function(BuildContext context) navigate;
}

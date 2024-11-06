part of 'splash_cubit.dart';

sealed class SplashState {
  const SplashState();
}

final class SplashInitialState implements SplashState {
  const SplashInitialState();
}

final class SplashNavigateState implements SplashState {
  const SplashNavigateState({required this.navigate});
  final void Function(BuildContext context) navigate;
}

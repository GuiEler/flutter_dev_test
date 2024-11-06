import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/theme/theme.dart';
import 'bloc/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final _splashCubit = context.read<SplashCubit>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => _splashCubit.goToLoginPage());
  }

  @override
  Widget build(BuildContext context) => BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateState) {
            state.navigate(context);
          }
        },
        child: const SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(color: GlobalColors.invert),
          ),
        ),
      );
}

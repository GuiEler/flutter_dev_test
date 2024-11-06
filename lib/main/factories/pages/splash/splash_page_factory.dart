import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation/pages/pages.dart';
import '../../../../presentation/pages/splash/bloc/splash_cubit.dart';

Widget makeSplashPage() => BlocProvider(
      create: (context) => SplashCubit(),
      child: const SplashPage(),
    );

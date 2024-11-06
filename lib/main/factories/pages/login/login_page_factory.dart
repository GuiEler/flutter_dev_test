import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/http/http.dart';
import '../../../../presentation/pages/login/blocs/login_cubit.dart';
import '../../../../presentation/pages/login/blocs/login_form_cubit.dart';
import '../../../../presentation/pages/pages.dart';
import '../../factories.dart';

Widget makeLoginPage() => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final HttpClient httpClient = makeDioAdapter();
            return LoginCubit(
              authLoginUsecase: makeRemoteAuthLogin(httpClient: httpClient),
              onClose: httpClient.close,
            );
          },
        ),
        BlocProvider(
          create: (context) => LoginFormCubit(
            validation: makeLoginValidation(),
          ),
        ),
      ],
      child: const LoginPage(),
    );

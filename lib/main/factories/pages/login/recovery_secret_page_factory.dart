import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/http/http.dart';
import '../../../../presentation/pages/login/blocs/code_field_cubit.dart';
import '../../../../presentation/pages/login/blocs/recovery_secret_cubit.dart';
import '../../../../presentation/pages/pages.dart';
import '../../factories.dart';

Widget makeRecoverySecretPage({required Object? extra}) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final HttpClient httpClient = makeDioAdapter();
            return RecoverySecretCubit(
              RecoverySecretInitialState(extra: extra),
              onClose: httpClient.close,
              authRecoverySecretUsecase: makeRemoteAuthRecoverySecret(httpClient: httpClient),
            );
          },
        ),
        BlocProvider(
          create: (context) => CodeFieldCubit(
            validation: makeRecoverySecretValidation(),
          ),
        ),
      ],
      child: const RecoverySecretPage(),
    );

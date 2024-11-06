import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/http/http.dart';
import '../../../../presentation/pages/login/blocs/recovery_secret_cubit.dart';
import '../../../../presentation/pages/pages.dart';
import '../../factories.dart';

Widget makeRecoverySecretPage() => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final HttpClient httpClient = makeDioAdapter();
            return RecoverySecretCubit(onClose: httpClient.close);
          },
        ),
      ],
      child: const RecoverySecretPage(),
    );

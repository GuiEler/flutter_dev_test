import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../shared/theme/theme.dart';
import 'routes.dart';

class MyHttpOverrides extends io.HttpOverrides {
  @override
  io.HttpClient createHttpClient(io.SecurityContext? context) =>
      super.createHttpClient(context)..badCertificateCallback = (cert, host, port) => true;
  // host == dotenv.env['HOST_DEV'] || host == dotenv.env['HOST_PROD'];
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = MyHttpOverrides();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'DevTest',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: GlobalColors.brown,
              size: 24,
            ),
            color: GlobalColors.invert,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: GlobalColors.invert,
              backgroundColor: GlobalColors.brown,
              disabledForegroundColor: GlobalColors.invert,
              disabledBackgroundColor: GlobalColors.brown.withOpacity(0.5),
              animationDuration: const Duration(milliseconds: 200),
              elevation: 0,
              padding: const EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          scaffoldBackgroundColor: GlobalColors.invert,
        ),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        locale: const Locale('pt', 'BR'),
        routerConfig: AppRouter.routerConfig,
      );
}

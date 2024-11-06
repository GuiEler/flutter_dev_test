import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import 'factories/pages/pages.dart';

enum AppRoutes {
  splash(name: 'Splash', path: '/'),
  login(name: 'Login', path: '/login'),
  recoverySecret(name: 'RecoverySecret', path: '/login/recoverySecret'),
  home(name: 'Home', path: '/home');

  final String name;
  final String path;
  const AppRoutes({
    required this.name,
    required this.path,
  });
}

mixin AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: 'Main Navigator');

  static final GoRouter routerConfig = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.splash.path,
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: makeSplashPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: makeLoginPage(),
        ),
        routes: [
          GoRoute(
            path: 'recoverySecret',
            name: AppRoutes.recoverySecret.name,
            pageBuilder: (context, state) => CupertinoPage(
              key: state.pageKey,
              child: makeLoginPage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.name,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: makeHomePage(),
        ),
      ),
    ],
    debugLogDiagnostics: kDebugMode,
  );
}

extension NavigationExtension on BuildContext {
  void popUntil(bool Function(GoRoute route) predicate) {
    final router = GoRouter.of(this);
    final GoRouterDelegate routerDelegate = router.routerDelegate;
    List<RouteMatchBase> matches = routerDelegate.currentConfiguration.matches;
    while (router.canPop()) {
      final routeMatch = matches.last;
      if (routeMatch.route is ShellRouteBase) {
        routerDelegate.currentConfiguration = routerDelegate.currentConfiguration.remove(routeMatch);
        matches = routerDelegate.currentConfiguration.matches;
        continue;
      }
      if (routeMatch.route is GoRoute) {
        final goRoute = routeMatch.route as GoRoute;
        if (predicate(goRoute)) {
          break;
        }
        if (!routerDelegate.canPop()) {
          break;
        }
        routerDelegate.pop();
      }
      matches = routerDelegate.currentConfiguration.matches;
    }
  }
}

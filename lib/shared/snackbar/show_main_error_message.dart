import 'package:flutter/material.dart';

import '../../main/routes.dart';
import '../theme/theme.dart';
import 'custom_snackbar.dart';

void showMainErrorMessage({bool useExpandedVersion = false, required String errorMessage}) {
  final context = AppRouter.navigatorKey.currentContext;
  if (context == null) {
    return;
  }

  final screenPadding = MediaQuery.paddingOf(context).bottom;
  final snackbar = CustomSnackBar(
    margin: EdgeInsets.fromLTRB(20, 0, 20, screenPadding + 24),
    borderRadius: 8,
    isDismissible: false,
    snackStyle: useExpandedVersion ? SnackStyle.grounded : SnackStyle.floating,
    backgroundColor: GlobalColors.primary,
    boxShadows: const [
      BoxShadow(
        blurRadius: 4,
        color: Color.fromRGBO(0, 0, 0, 0.2),
        offset: Offset(0, 3),
      ),
      BoxShadow(
        blurRadius: 18,
        color: Color.fromRGBO(0, 0, 0, 0.12),
        offset: Offset(0, 1),
      ),
      BoxShadow(
        blurRadius: 10,
        color: Color.fromRGBO(0, 0, 0, 0.14),
        offset: Offset(0, 6),
      ),
    ],
    onTap: (_) => SnackbarController.closeCurrentSnackbar(),
    duration: const Duration(seconds: 2),
    messageText: Text(
      errorMessage,
      style: TextStyles.callout.copyWith(
        color: GlobalColors.surface,
      ),
      textAlign: TextAlign.left,
    ),
  );
  SnackbarController(snackbar).show();
}

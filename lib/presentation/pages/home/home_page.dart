import 'package:flutter/material.dart';

import '../../../shared/theme/theme.dart';
import '../../helpers/i18n/i18n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text(
            R.strings.home,
            style: TextStyles.subheading.copyWith(color: GlobalColors.secondary),
          ),
        ),
      );
}

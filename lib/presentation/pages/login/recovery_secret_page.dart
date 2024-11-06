import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../shared/theme/theme.dart';
import '../../helpers/i18n/i18n.dart';

class RecoverySecretPage extends StatefulWidget {
  const RecoverySecretPage({super.key});

  @override
  State<RecoverySecretPage> createState() => _RecoverySecretPageState();
}

class _RecoverySecretPageState extends State<RecoverySecretPage> {
  late final double screenWidth = MediaQuery.sizeOf(context).width;
  late final double logoPadding = screenWidth * 0.2;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        R.strings.verification,
                        style: TextStyles.heading,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4, bottom: logoPadding),
                        child: Text(
                          R.strings.insertTheSendedCode,
                          style: TextStyles.subheading.copyWith(color: GlobalColors.secondary),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(
                              IconsaxPlusLinear.message_question,
                              color: GlobalColors.brown,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              R.strings.doNotReceivedTheCode,
                              style: TextStyles.label.copyWith(color: GlobalColors.onBackground),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

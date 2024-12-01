import 'dart:io';

import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class BottomButon extends StatelessWidget {
  const BottomButon({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = Platform.isIOS ? size.height * 0.12 : size.height * 0.1;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: double.infinity,
      height: height,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: Platform.isIOS ? size.height * 0.04 : 0),
        child: Center(
          child: Buton(
            background: c.primary600,
            title: 'Enviar',
            style: t.mediumLight,
            onTap: () => onTap(),
          ),
        ),
      ),
    );
  }
}

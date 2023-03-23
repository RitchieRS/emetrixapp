import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:flutter/material.dart';

class GradientTitle extends StatelessWidget {
  const GradientTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: const [0.1, 0.5],
        colors: [c.secondary, c.primary.withOpacity(0.55)],
      )),
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.035),
        child: AppBar(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Fuera de', style: t.textLight),
                Text('RUTA', style: t.titleLight),
              ],
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true),
      ),
    );
  }
}

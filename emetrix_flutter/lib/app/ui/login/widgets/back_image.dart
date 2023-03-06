import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:flutter/material.dart';

class BackImage extends StatelessWidget {
  const BackImage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: const [0.1, 0.55],
        colors: [c.primary, c.secondary.withOpacity(0.95)],
      )),
      child: Padding(
        padding: EdgeInsets.only(
            bottom: size.height * 0.5,
            left: size.width * 0.2,
            right: size.width * 0.2),
        child: Image.asset('assets/images/logo_blanco.png'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class BackImage extends StatelessWidget {
  const BackImage({super.key});

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
        colors: [
          c.secondary,
          c.primary.withOpacity(0.55),
        ],
      )),
      child: Padding(
        padding: EdgeInsets.only(
            bottom: size.height * 0.5,
            left: size.width * 0.27,
            right: size.width * 0.27),
        child: Image.asset('assets/images/logo_blanco.png'),
      ),
    );
  }
}

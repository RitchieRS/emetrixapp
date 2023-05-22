import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListView(
      children: [
        //
        FadeIn(
          child: Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: SvgPicture.asset(
              AppAssets.location,
              height: size.height * 0.2,
            ),
          ),
        ),
        FadeIn(
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
                'No hay rutas añadidas. Escoge tus ruta/s en el apartado "Fuera de Ruta" para comenzar.'),
          ),
        ),
      ],
    );
  }
}

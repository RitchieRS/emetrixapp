import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('Ruta', style: t.titleBlue),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.05),
          child: SvgPicture.asset(
            'assets/images/location.svg',
            height: size.height * 0.2,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
              'No hay rutas añadidas. Escoge tus ruta/s en el apartado "Fuera de Ruta" para comenzar.'),
        ),
      ],
    );
  }
}

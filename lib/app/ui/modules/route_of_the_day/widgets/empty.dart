import 'package:emetrix_flutter/app/ui/modules/out_of_route/out_of_route.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final verticalPadding = size.height * 0.03;

    return FadeIn(
      child: ListView(
        children: [
          //

          Padding(
            padding: EdgeInsets.only(top: verticalPadding),
            child: SvgPicture.asset(
              AppAssets.location,
              height: size.height * 0.2,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: verticalPadding),
                  child: Text('No hay rutas para visitar.',
                      style: t.subtitle, textAlign: TextAlign.left),
                ),
                Text(
                    'Añade tus ruta/s en el apartado "Fuera de Ruta" para comenzar tus visitaciones.',
                    style: t.text2,
                    textAlign: TextAlign.left),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const OutOfRoutePage())),
                      child: const Text('Añadir Rutas')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

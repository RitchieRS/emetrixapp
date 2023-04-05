import 'package:animate_do/animate_do.dart';
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
          padding: EdgeInsets.only(top: size.height * 0.035),
          child: AppBar(
              automaticallyImplyLeading: false,
              // leading: IconButton(
              //     onPressed: () => Navigator.pop(context),
              //     icon: Icon(Icons.arrow_back_ios, color: c.primary)),
              title: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text('RUTA', style: t.titleBlue),
                  Text('Del Dia', style: t.textBlue),
                ],
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true),
        ),
        //
        FadeIn(
          child: Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: SvgPicture.asset(
              'assets/images/location.svg',
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

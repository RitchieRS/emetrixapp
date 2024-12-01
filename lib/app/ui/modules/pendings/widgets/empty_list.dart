import 'package:animate_do/animate_do.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    super.key,
    required this.onRefresh,
  });
  final Future<void> onRefresh;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final verticalPadding = size.height * 0.03;

    return FadeIn(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: verticalPadding),
            child: SvgPicture.asset(
              AppAssets.noData,
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
                  child: Text('No hay pendientes.',
                      style: t.subtitle, textAlign: TextAlign.left),
                ),
                Text(
                    'Al finalizar un sondeo se guardarán automaticamente en esta sección.',
                    style: t.text2,
                    textAlign: TextAlign.left),
              ],
            ),
          ),
        ],
      ),
    );

    // Scaffold(
    //   appBar: const GeneralTitle(title: 'Pendientes', showMenu: true),
    //   body: FadeIn(
    //     child: RefreshIndicator(
    //       onRefresh: () => onRefresh,
    //       child: ListView(
    //         children: [
    //           Padding(
    //             padding: EdgeInsets.only(top: verticalPadding),
    //             child: SvgPicture.asset(
    //               AppAssets.noData,
    //               height: size.height * 0.2,
    //             ),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Padding(
    //                   padding: EdgeInsets.only(top: verticalPadding),
    //                   child: Text('No hay pendientes.',
    //                       style: t.subtitle, textAlign: TextAlign.left),
    //                 ),
    //                 Text(
    //                     'Al finalizar un sondeo se guardarán automaticamente en esta sección.',
    //                     style: t.text2,
    //                     textAlign: TextAlign.left),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/modules/route_of_the_day/controller.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/controller.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/type_sondeo.dart';

import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';
import 'sondeo_individual.dart';

class SondeoPage extends ConsumerStatefulWidget {
  const SondeoPage({super.key, required this.sondeosList, required this.store});
  final List<RespM> sondeosList;
  final Store store;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SondeoPageState();
}

class _SondeoPageState extends ConsumerState<SondeoPage> {
  List<RespM> sondeosList2 = [];

  @override
  void initState() {
    super.initState();

    setState(() {});
    sondeosList2 =
        ref.read(sondeoController.notifier).reorderList(widget.sondeosList);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider);

    return WillPopScope(
      onWillPop: () async {
        return await onPop();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('${widget.store.tienda}',
              style:
                  isDark == ThemeMode.dark ? t.subtitleLight : t.subtitleDark,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: size.height * 0.1,
        ),
        body: ListView(
          children: [
            //
            ListView.builder(
              padding: EdgeInsets.only(
                  top: 0, left: size.height * 0.01, right: size.height * 0.01),
              itemCount: sondeosList2.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final List<int> finisedSections = [
                  0,
                ];

                return TypeSondeo(
                  onTap:
                      // finisedSections.contains(index) ?
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SondeosBuilder(
                                  sondeoItem: sondeosList2[index],
                                )));
                  },
                  // : null,
                  type: sondeosList2[index].sondeo ?? 'Error',
                  index: index,
                  finisedSections: finisedSections,
                  isLast: index + 1 == sondeosList2.length ? true : false,
                );
                // QuestionBuilder(
                //     pregunta: widget.sondeo.preguntas?[index] ?? Preguntas());
              },
            ),
            //
          ],
        ),
      ),
    );
  }

  Future<bool> onPop() async {
    final bool exit = await showMsj(
        context: context,
        title: 'Cuidado...',
        content:
            'Perderás todo el progreso si sales ahora. ¿Seguro deseas salir?',
        destructive: true,
        buttonLabel: 'Salir');

    setState(() {
      ref.read(showProgress1.notifier).update((state) => false);
    });

    return Future.value(exit);
  }
}

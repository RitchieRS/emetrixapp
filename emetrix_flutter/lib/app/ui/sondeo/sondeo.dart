import 'package:emetrix_flutter/app/core/services/main.dart';
import 'package:emetrix_flutter/app/core/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/controller.dart';
import 'package:emetrix_flutter/app/ui/sondeo/components/type_sondeo.dart';
import 'package:emetrix_flutter/app/ui/sondeo/controller.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    setState(() {
      sondeosList2 =
          ref.read(sondeoController.notifier).reorderList(widget.sondeosList);
    });
    Services.checkConectivity();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return await onPop();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('${widget.store.tienda}',
              style: t.subtitle,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2),
          backgroundColor: ThemeData().scaffoldBackgroundColor,
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
                  onTap: finisedSections.contains(index) ? () {} : null,
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

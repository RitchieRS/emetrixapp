import 'package:emetrix_flutter/app/core/services/main.dart';
import 'package:emetrix_flutter/app/core/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/controller.dart';
import 'package:emetrix_flutter/app/ui/sondeo/components/type_builder.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SondeoPage extends ConsumerStatefulWidget {
  const SondeoPage({super.key, required this.sondeo, required this.store});
  final RespM sondeo;
  final Store store;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SondeoPageState();
}

class _SondeoPageState extends ConsumerState<SondeoPage> {
  @override
  void initState() {
    super.initState();
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
              itemCount: widget.sondeo.preguntas?.length ?? 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final List<int> finisedSections = [0, 1, 2];

                return TypeBuilder(
                  onTap: finisedSections.contains(index) ? () {} : null,
                  type: widget.sondeo.preguntas?[index].pregunta ?? 'Error',
                  index: index,
                  finisedSections: finisedSections,
                  isLast: index + 1 == widget.sondeo.preguntas?.length
                      ? true
                      : false,
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

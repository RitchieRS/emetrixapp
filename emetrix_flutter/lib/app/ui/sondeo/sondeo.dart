import 'package:emetrix_flutter/app/core/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SondeoPage extends ConsumerStatefulWidget {
  const SondeoPage({super.key, required this.sondeo});
  final RespM sondeo;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SondeoPageState();
}

class _SondeoPageState extends ConsumerState<SondeoPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  left: size.height * 0.018, top: size.height * 0.03),
              child:
                  Text('Sondeo: ${widget.sondeo.sondeo}', style: t.titleBlue)),

          //
          ListView.builder(
            padding: EdgeInsets.only(
                top: size.height * 0.02,
                left: size.height * 0.01,
                right: size.height * 0.01),
            itemCount: widget.sondeo.preguntas?.length ?? 2,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              debugPrint('length --->${widget.sondeo.toString()}');
              return Text(
                  '${index + 1}.- ${widget.sondeo.preguntas?[index].pregunta}');
            },
          ),
          //
          // Text('Info: ${widget.sondeo.preguntas?.length.toString()}'),
          // Text('Info: ${widget.sondeo.preguntas?.first.pregunta}'),
          // Text('Info: ${widget.sondeo.preguntas?.first.tipo}'),
        ],
      ),
    );
  }
}

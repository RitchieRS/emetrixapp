import 'package:emetrix_flutter/app/core/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SondeoPage extends ConsumerStatefulWidget {
  const SondeoPage({super.key, required this.sondeo});
  final SondeoModel sondeo;

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
            child: Text('Sondeo: ${widget.sondeo.resp?.first.sondeo}',
                style: t.titleBlue),
          ),

          //
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child: ListView.builder(
              itemCount: widget.sondeo.resp?.first.preguntas?.length ?? 2,
              shrinkWrap: true,
              // separatorBuilder: (BuildContext context, int index) {
              //   return const Divider(color: Colors.transparent);
              // },
              itemBuilder: (BuildContext context, int index) {
                debugPrint(
                    'length --->${widget.sondeo.resp?[index].preguntas?.length.toString()}');
                return Text(
                    'Preguntas: ${widget.sondeo.resp?.first.preguntas?[index].pregunta}');
              },
            ),
          ),
          //
          Text(
              'Info: ${widget.sondeo.resp?.first.preguntas?.length.toString()}'),
          Text('Info: ${widget.sondeo.resp?.first.preguntas?.first.pregunta}'),
          Text('Info: ${widget.sondeo.resp?.first.preguntas?.first.tipo}'),
        ],
      ),
    );
  }
}

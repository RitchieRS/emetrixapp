import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class SondeosBuilder extends ConsumerWidget {
  const SondeosBuilder({super.key, required this.sondeoItem});
  final RespM sondeoItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    double lenght = sondeoItem.preguntas?.length.toDouble() ?? 0;
    double value = (lenght / 2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: c.surface,
        title: Text('${sondeoItem.sondeo}', style: t.medium),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).hintColor,
        toolbarHeight: size.height * 0.07,
      ),
      body: //PageView builder,
          ListView(
        children: [
          Container(
            color: c.surface,
            child: Padding(
                padding:
                    const EdgeInsets.only(left: 14.0, right: 14, bottom: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: size.height * 0.008,
                  ),
                )),
          ),
          if (sondeoItem.preguntas != null)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sondeoItem.preguntas?.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Text(
                    '${sondeoItem.preguntas?[index].pregunta} ',
                    textAlign: TextAlign.center,
                  ),
                  Text('Pregunta ${index + 1} de ${lenght.ceil()} \n'),
                ],
              ),
            )
          else
            Text('${sondeoItem.linkWeb}')
        ],
      ),
    );
  }
}

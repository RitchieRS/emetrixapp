// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/components.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class QuestionBuilder extends ConsumerStatefulWidget {
  const QuestionBuilder({
    super.key,
    required this.pregunta,
    required this.store,
  });
  final Preguntas pregunta;
  final Store store;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuestionBuilderState();
}

class _QuestionBuilderState extends ConsumerState<QuestionBuilder> {
  // List<String> lenght = [];

  @override
  Widget build(BuildContext context) {
    switch (widget.pregunta.pregunta) {
      //Asistencia
      case 'ASISTENCIA':
        return MapView(store: widget.store);

      //todo
      case 'Pregunta abierta 2':
        return Question(
          pregunta: widget.pregunta,
          getAnswer: (String answer) {
            //Get the value of the textfield and save it to validate and send to endpoint;
          },
        );
      case 'Pregunta demo abierta':
        return Question(
          pregunta: widget.pregunta,
          getAnswer: (String answer) {
            //Get the value of the textfield and save it to validate and send to endpoint;
          },
        );
      case 'Pregunta demo numérica':
        return Question(
            pregunta: widget.pregunta,
            getAnswer: (String answer) {
              //Get the value of the textfield and save it to validate and send to endpoint;
            },
            isNumeric: true);

      case 'Pregunta demo decimal (con limite minimo 5 y maximo 10)':
        return Question(
            pregunta: widget.pregunta,
            getAnswer: (String answer) {
              //Get the value of the textfield and save it to validate and send to endpoint;
            },
            isNumeric: true,
            min: 5,
            max: 10);

      case 'Pregunta demo si o no':
        return Selection(
            pregunta: widget.pregunta, question: widget.pregunta, yesNo: true);

      case 'Pregunta demo de opción multiple con 1 selección':
        return Selection(pregunta: widget.pregunta, question: widget.pregunta);

      case 'Pregunta demo de opción multiple con N selecciones':
        return SelectionMultiple(question: widget.pregunta);

      case '--Pregunta informativa--':
        return InfoQuestion(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'Pregunta demo fotográfica':
        return SelectPicture(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'Pregunta demo GPS':
        return Container(
          color: c.surface,
          child: Text('Pregunta demo GPS', style: t.medium),
        );

      case 'Pregunta demo de 3 tiempos con el cronómetro.':
        return Container(
          color: c.surface,
          child: Text('3 tiempos con el cronómetro.', style: t.medium),
        );

      case 'Pregunta demo imágen':
        return SelectPicture(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'Pregunta demo de firma':
        return const Signature();

      case 'Pregunta demo fecha':
        return PickerDT(
            pregunta: widget.pregunta.pregunta ?? 'NoData', onlyDate: true);

      case 'Pregunta demo fecha y hora':
        return PickerDT(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'Pregunta demo hora':
        return PickerDT(
            pregunta: widget.pregunta.pregunta ?? 'NoData', onlyTime: true);

      case 'ESCANEA EL CÓDIGO':
        return Container(
          color: c.surface,
          child: Text('ESCANEA EL CÓDIGO', style: t.medium),
        );

      //Tomar Fotografía
    }

    return Center(child: Text(widget.pregunta.pregunta ?? 'NoData'));
  }
}

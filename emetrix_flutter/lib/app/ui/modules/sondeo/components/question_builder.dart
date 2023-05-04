// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/components.dart';

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
    print('TIPO: ${widget.pregunta.tipo}');

    switch (widget.pregunta.tipo) {
      //Asistencia
      case 'asistencia':
        return MapView(store: widget.store);

      //Tomar Fotografía
      case 'unicaRadio':
        return Selection(pregunta: widget.pregunta, question: widget.pregunta);

      case 'fotoGuardarCopia':
        return SelectPicture(pregunta: widget.pregunta.pregunta ?? 'NoData');

      //todo
      case 'abierta':
        return Question(
          pregunta: widget.pregunta,
          getAnswer: (String answer) {
            //Get the value of the textfield and save it to validate and send to endpoint;
          },
        );

      case 'numerico':
        return Question(
            pregunta: widget.pregunta,
            getAnswer: (String answer) {
              //Get the value of the textfield and save it to validate and send to endpoint;
            },
            isNumeric: true);

      case 'decimal':
        return Question(
            pregunta: widget.pregunta,
            getAnswer: (String answer) {
              //Get the value of the textfield and save it to validate and send to endpoint;
            },
            isNumeric: true,
            min: 5,
            max: 10);

      case 'sino':
        return Selection(
            pregunta: widget.pregunta, question: widget.pregunta, yesNo: true);

      case 'multiple':
        return SelectionMultiple(question: widget.pregunta);

      case 'informativo':
        return InfoQuestion(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'foto':
        return SelectPicture(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'gps':
        return Gps(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'tiempo':
        return MyTimer(
            pregunta: widget.pregunta.pregunta ?? 'NoData', times: 2);

      case 'imagen':
        return SelectPicture(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'firma':
        return Signature(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'fecha':
        return PickerDT(
            pregunta: widget.pregunta.pregunta ?? 'NoData', onlyDate: true);

      case 'fechaHora':
        return PickerDT(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'hora':
        return PickerDT(
            pregunta: widget.pregunta.pregunta ?? 'NoData', onlyTime: true);

      case 'scannerQR':
        return const Scanner();

      //FOTOS
      //preguntas
      //SOS
      //cronometro 2
      //cronometro 4
      //Carga de Videos
      //NFC

      case 'email':
        return Question(
          pregunta: widget.pregunta,
          getAnswer: (String answer) {
            //Get the value of the textfield and save it to validate and send to endpoint;
          },
        );
    }

    return Center(child: Text(widget.pregunta.pregunta ?? 'NoData'));
  }
}

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
    required this.index,
    this.textController,
  });
  final Preguntas pregunta;
  final Store store;
  final int index;
  final TextEditingController? textController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuestionBuilderState();
}

class _QuestionBuilderState extends ConsumerState<QuestionBuilder>
    with AutomaticKeepAliveClientMixin {
  // List<String> lenght = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    switch (widget.pregunta.tipo) {
      //Tomar Fotografía
      case 'unicaRadio':
        return Selection(pregunta: widget.pregunta, question: widget.pregunta);

      case 'fotoGuardarCopia':
        return SelectPicture(pregunta: widget.pregunta.pregunta ?? 'NoData');

      //todo
      case 'abierta':
        return Question(
          type: widget.pregunta.tipo ?? 'abierto',
          controller: widget.textController,
          index: widget.index,
          pregunta: widget.pregunta,
          answer: (String answer) {
            // print('Respuesta: $answer');
            //Get the value of the textfield and save it to validate and send to endpoint;
          },
        );

      case 'numerico':
        return Question(
            type: widget.pregunta.tipo ?? 'abierto',
            controller: widget.textController,
            index: widget.index,
            pregunta: widget.pregunta,
            answer: (String answer) {
              //Get the value of the textfield and save it to validate and send to endpoint;
            },
            isNumeric: true);

      case 'decimal':
        return Question(
            type: widget.pregunta.tipo ?? 'abierto',
            controller: widget.textController,
            index: widget.index,
            pregunta: widget.pregunta,
            answer: (String answer) {
              //Get the value of the textfield and save it to validate and send to endpoint;
            },
            isDecimal: true,
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
            getDateTime: (dateTime) {
              print(dateTime);
            },
            pregunta: widget.pregunta.pregunta ?? 'NoData',
            onlyDate: true);

      case 'fechaHora':
        return PickerDT(
            getDateTime: (dateTime) {
              print(dateTime);
            },
            pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'hora':
        return PickerDT(
            getDateTime: (dateTime) {
              print(dateTime);
            },
            pregunta: widget.pregunta.pregunta ?? 'NoData',
            onlyTime: true);

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
          type: widget.pregunta.tipo ?? 'abierto',
          controller: widget.textController,
          index: widget.index,
          pregunta: widget.pregunta,
          answer: (String answer) {
            //Get the value of the textfield and save it to validate and send to endpoint;
          },
        );
    }

    return Center(child: Text(widget.pregunta.pregunta ?? 'NoData'));
  }

  setTextControllers(Preguntas pregunta) {
    // pregunta.tipo
  }

  @override
  bool get wantKeepAlive => true;
}

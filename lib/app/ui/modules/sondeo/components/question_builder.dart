// ignore_for_file: avoid_print
import 'dart:io';
import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/area.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/areas_multiples.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/sondeo_individual.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/components.dart';
import 'package:intl/intl.dart';

class QuestionBuilder extends ConsumerStatefulWidget {
  QuestionBuilder({
    super.key,
    this.mandatory = false,
    required this.pregunta,
    required this.store,
    required this.index,
    required this.answer,
    required this.answerRadio,
    required this.image,
    required this.positionGPS,
    required this.signature,
    required this.date,
    required this.dateTime,
    required this.time,
    required this.numeric,
    required this.decimal,
    required this.email,
    required this.yesnoRadio,
    required this.foto,
    required this.tiempo,
    required this.selectionMultiple,
    required this.answerController,
    required this.callback,
    required this.preguntasdep,
    required this.areas,
    required this.areasMultiples,
  });
  final Preguntas pregunta;
  final Store2 store;
  final int index;
  final bool mandatory;
  final Function(String? response) answer;
  final Function(String? response) numeric;
  final Function(String? response) decimal;
  final Function(String? response) email;
  final Function(String?) answerRadio;
  final Function(String?) yesnoRadio;
  final Function(String?) selectionMultiple;
  final Function(String?) positionGPS;
  final Function(String?) date;
  final Function(String?) dateTime;
  final Function(String?) time;
  final Function(String?) tiempo;
  final Function(File?) image;
  final Function(String) foto;
  final Function(String?) signature;
  final Function(String?) areas;
  final Function(List<Coordinate>?) areasMultiples;
  final Function(String?, String?) callback;
  final Function(TextEditingController controller, String uuid)
      answerController;

  List<Preguntas> preguntasdep = [];

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuestionBuilderState();
}

// Callback function to be called by the child

class _QuestionBuilderState extends ConsumerState<QuestionBuilder> {
  String respuestaDependiente = '';
  void updateData(String? idPregunta, String? response) {
    widget.callback(idPregunta, response!);
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.pregunta.tipo) {
      // case 'asistencia':
      //   return MapView(store: widget.store);

      case 'unicaRadio':
        /*return Selection(
          pregunta: widget.pregunta,
          question: widget.pregunta,
          answer: (String? response) {
            widget.answerRadio(response);
          },
          mandatory: widget.mandatory,
        );*/
        return SelectionMultiple(
          question: widget.pregunta,
          selectedItems: (selectedItems) {
            String formattedList = "";
            if (selectedItems != null) {
              formattedList = selectedItems.join(', ');
            }
            widget.answerRadio(formattedList);
          },
          mandatory: widget.mandatory,
          callback: updateData,
        );

      case 'fotoGuardarCopia':
        return SelectPicture(
          pregunta: widget.pregunta,
          saveCopy: true,
          image: (image) {
            print('Image: $image');
            widget.image(image);
          },
          mandatory: widget.mandatory,
        );

      // //todo
      case 'abierta':
        return Question(
          type: widget.pregunta.tipo ?? 'abierta',
          index: widget.index,
          pregunta: widget.pregunta,
          sendController: (TextEditingController controller) {
            widget.answerController(controller, widget.pregunta.uuid ?? '');
          },
          answer: (String? answer) {
            widget.answer(answer);
            //Get the value of the textfield and save it to validate and send to endpoint;
          },
          charactersMin: widget.pregunta.valorMinimo,
          charactersMax: widget.pregunta.valorMaximo,
          mandatory: widget.mandatory,
        );

      case 'numerico':
        return Question(
          type: widget.pregunta.tipo ?? 'numerico',
          index: widget.index,
          pregunta: widget.pregunta,
          sendController: (TextEditingController controller) {
            //
          },
          answer: (String? answer) {
            widget.numeric(answer.toString());
          },
          valueMin: widget.pregunta.valorMinimo,
          valueMax: widget.pregunta.valorMaximo,
          mandatory: widget.mandatory,
        );

      case 'email':
        return Question(
          type: widget.pregunta.tipo ?? 'email',
          index: widget.index,
          pregunta: widget.pregunta,
          sendController: (TextEditingController controller) {
            //
          },
          answer: (String? answer) {
            widget.email(answer);
          },
          valueMin: widget.pregunta.valorMinimo,
          valueMax: widget.pregunta.valorMaximo,
          mandatory: widget.mandatory,
        );

      case 'decimal':
        return Question(
          type: widget.pregunta.tipo ?? 'decimal',
          index: widget.index,
          pregunta: widget.pregunta,
          sendController: (TextEditingController controller) {
            //
          },
          answer: (String? answer) {
            widget.decimal(answer);
          },
          valueMin: widget.pregunta.valorMinimo,
          valueMax: widget.pregunta.valorMaximo,
          mandatory: widget.mandatory,
        );

      case 'sino':
        return Selection(
          pregunta: widget.pregunta,
          question: widget.pregunta,
          yesNo: true,
          answer: (String? response) {
            widget.yesnoRadio(response);
          },
          mandatory: widget.mandatory,
        );
      /*
        return SelectionMultiple(
          question: widget.pregunta,
          selectedItems: (selectedItems) {
            widget.selectionMultiple(selectedItems);
          },
          mandatory: widget.mandatory,
          callback: updateData,
        );

        */

      case 'multiple':
        return SelectionMultiple(
          question: widget.pregunta,
          selectedItems: (selectedItems) {
            String formattedList = "";
            if (selectedItems != null) {
              formattedList = selectedItems.join('<@>|');
            }
            widget.selectionMultiple(formattedList);
          },
          mandatory: widget.mandatory,
          callback: updateData,
        );

      case 'informativo':
        return InfoQuestion(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'foto':
        return ImagesCarrusel(
          pregunta: widget.pregunta,
          image: (image) {
            widget.foto(image?.path.toString() ?? '');
          },
          mandatory: widget.mandatory,
          multiple: false,
        );
      case 'imagen':
        return SelectPicture(
          pregunta: widget.pregunta,
          image: (image) {
            widget.image(image);
          },
          mandatory: widget.mandatory,
        );

      case 'carrusel':
        return ImagesCarrusel(
          pregunta: widget.pregunta,
          image: (image) {
            widget.image(image);
          },
          mandatory: widget.mandatory,
          multiple: true,
        );

      case 'gps':
        return Gps(
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          preguntawid: widget.pregunta,
          answer: (position) {
            widget.positionGPS(position!.toString());
          },
          mandatory: widget.mandatory,
        );

      case 'tiempo':
        return MyTimer(
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          preguntawid: widget.pregunta,
          times: widget.pregunta.capturaNTiempos ?? 1,
          mandatory: widget.mandatory,
          listTimes: (list) {
            String formattedList = "";
            if (list.isNotEmpty) {
              if (list.length > 2) {
                formattedList = list.join(',');
              } else {
                formattedList = list.toString();
              }
            }
            widget.tiempo(formattedList);
          },
        );

      case 'firma':
        return Signature(
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          preguntawid: widget.pregunta,
          getSignature: (signatureFile) {
            widget.signature(signatureFile!.path.toString());
          },
          mandatory: widget.mandatory,
        );

      case 'fecha':
        return PickerDT(
          getDateTime: (date) {
            String dateOnly = DateFormat('yyyy-MM-dd').format(date!);
            widget.date(dateOnly.toString());
          },
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          preguntaId: widget.pregunta,
          onlyDate: true,
          mandatory: widget.mandatory,
        );

      case 'fechaHora':
        return PickerDT(
          getDateTime: (dateTime) {
            DateTime datetime = DateTime.parse(dateTime.toString());
            String formattedDateTime =
                DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);
            widget.dateTime(formattedDateTime);
          },
          preguntaId: widget.pregunta,
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          mandatory: widget.mandatory,
        );

      case 'hora':
        return PickerDT(
          getDateTime: (time) {
            String formattedDateTime = DateFormat('HH:mm:ss').format(time!);
            widget.time(formattedDateTime);
          },
          preguntaId: widget.pregunta,
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          onlyTime: true,
          mandatory: widget.mandatory,
        );

      case 'scannerQR':
        return Scanner(
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          mandatory: widget.mandatory,
        );

      case 'areas':
        return AreasMultiples(
          mandatory: widget.mandatory,
          pregunta: widget.pregunta,
          listPreguntas: widget.preguntasdep,
          callback: updateData,
          selectedAreas: (areas) {
            widget.areas(areas.toString());
          },
          multiple: false,
        );

      case 'areasMultiples':
        return AreasMultiples(
          mandatory: widget.mandatory,
          pregunta: widget.pregunta,
          listPreguntas: widget.preguntasdep,
          callback: updateData,
          selectedAreas: (areas) {
            widget.areasMultiples(areas);
            logger.i(areas.toString());
          },
          multiple: true,
        );
    }

    return Text(widget.pregunta.pregunta ?? 'NoData');
  }
}

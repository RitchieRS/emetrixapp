// ignore_for_file: avoid_print
import 'dart:io';

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
    required this.answer,
    required this.answerRadio,
    required this.image,
    required this.positionGPS,
    required this.signature,
    required this.date,
    required this.dateTime,
    required this.time,
  });
  final Preguntas pregunta;
  final Store store;
  final int index;
  final Function(String?) answer;
  final Function(String?) answerRadio;
  final Function(String?) positionGPS;
  final Function(DateTime?) date;
  final Function(DateTime?) dateTime;
  final Function(DateTime?) time;
  final Function(File?) image;
  final Function(File?) signature;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuestionBuilderState();
}

class _QuestionBuilderState extends ConsumerState<QuestionBuilder> {
  @override
  Widget build(BuildContext context) {
    switch (widget.pregunta.tipo) {
      case 'asistencia':
        return MapView(store: widget.store);

      case 'unicaRadio':
        return Selection(
          pregunta: widget.pregunta,
          question: widget.pregunta,
          answer: (String? response) {
            widget.answerRadio(response);
          },
        );

      case 'fotoGuardarCopia':
        return SelectPicture(
          pregunta: widget.pregunta,
          saveCopy: true,
          image: (image) {
            print('Image: $image');
            widget.image(image);
          },
        );

      // //todo
      case 'abierta':
        return Question(
          type: widget.pregunta.tipo ?? 'abierta',
          index: widget.index,
          pregunta: widget.pregunta,
          answer: (String? answer) {
            widget.answer(answer);
            //Get the value of the textfield and save it to validate and send to endpoint;
          },
          charactersMin: widget.pregunta.valorMinimo,
          charactersMax: widget.pregunta.valorMaximo,
        );

      case 'numerico':
        return Question(
          type: widget.pregunta.tipo ?? 'abierta',
          index: widget.index,
          pregunta: widget.pregunta,
          answer: (String? answer) {
            widget.answer(answer);
          },
          valueMin: widget.pregunta.valorMinimo,
          valueMax: widget.pregunta.valorMaximo,
        );

      case 'decimal':
        return Question(
          type: widget.pregunta.tipo ?? 'abierta',
          index: widget.index,
          pregunta: widget.pregunta,
          answer: (String? answer) {
            widget.answer(answer);
          },
          valueMin: widget.pregunta.valorMinimo,
          valueMax: widget.pregunta.valorMaximo,
        );

      case 'sino':
        return Selection(
          pregunta: widget.pregunta,
          question: widget.pregunta,
          yesNo: true,
          answer: (String? response) {
            widget.answerRadio(response);
          },
        );

      case 'multiple':
        return SelectionMultiple(
          question: widget.pregunta,
          selectedItems: (selectedItems) {
            //
            print('SELECT MULTI: $selectedItems');
          },
        );

      case 'informativo':
        return InfoQuestion(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'foto':
        return SelectPicture(
          pregunta: widget.pregunta,
          image: (image) {
            widget.image(image);
          },
        );

      case 'gps':
        return Gps(
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          answer: (position) {
            widget.positionGPS(position);
          },
        );

      case 'tiempo':
        return MyTimer(
            pregunta: widget.pregunta.pregunta ?? 'NoData', times: 2);

      case 'imagen':
        return SelectPicture(
          pregunta: widget.pregunta,
          image: (image) {
            widget.image(image);
          },
        );

      case 'firma':
        return Signature(
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          getSignature: (signatureFile) {
            widget.signature(signatureFile);
          },
        );

      case 'fecha':
        return PickerDT(
            getDateTime: (date) {
              widget.date(date);
              print(date);
            },
            pregunta: widget.pregunta.pregunta ?? 'NoData',
            onlyDate: true);

      case 'fechaHora':
        return PickerDT(
            getDateTime: (dateTime) {
              widget.dateTime(dateTime);
              print(dateTime);
            },
            pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'hora':
        return PickerDT(
            getDateTime: (time) {
              widget.time(time);
              print(time);
            },
            pregunta: widget.pregunta.pregunta ?? 'NoData',
            onlyTime: true);

      case 'scannerQR':
        return Scanner(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'email':
        return Question(
          type: widget.pregunta.tipo ?? 'abierta',
          index: widget.index,
          pregunta: widget.pregunta,
          answer: (String? answer) {
            widget.answer(answer);
          },
        );
    }

    return Text(widget.pregunta.pregunta ?? 'NoData');
  }
}

// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/components.dart';

class QuestionBuilder extends ConsumerStatefulWidget {
  const QuestionBuilder({
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
    required this.photo,
    required this.selectionMultiple,
  });
  final Preguntas pregunta;
  final Store2 store;
  final int index;
  final bool mandatory;
  final Function(String?) answer;
  final Function(String?) numeric;
  final Function(String?) decimal;
  final Function(String?) email;
  final Function(String?) answerRadio;
  final Function(String?) yesnoRadio;
  final Function(List<String>?) selectionMultiple;
  final Function(String?) positionGPS;
  final Function(DateTime?) date;
  final Function(DateTime?) dateTime;
  final Function(DateTime?) time;
  final Function(File?) image;
  final Function(File?) photo;
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
          mandatory: widget.mandatory,
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
          type: widget.pregunta.tipo ?? 'abierta',
          index: widget.index,
          pregunta: widget.pregunta,
          answer: (String? answer) {
            widget.numeric(answer);
          },
          valueMin: widget.pregunta.valorMinimo,
          valueMax: widget.pregunta.valorMaximo,
          mandatory: widget.mandatory,
        );

      case 'email':
        return Question(
          type: widget.pregunta.tipo ?? 'abierta',
          index: widget.index,
          pregunta: widget.pregunta,
          answer: (String? answer) {
            widget.email(answer);
          },
          valueMin: widget.pregunta.valorMinimo,
          valueMax: widget.pregunta.valorMaximo,
          mandatory: widget.mandatory,
        );

      case 'decimal':
        return Question(
          type: widget.pregunta.tipo ?? 'abierta',
          index: widget.index,
          pregunta: widget.pregunta,
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

      case 'multiple':
        return SelectionMultiple(
          question: widget.pregunta,
          selectedItems: (selectedItems) {
            widget.selectionMultiple(selectedItems);
          },
          mandatory: widget.mandatory,
        );

      case 'informativo':
        return InfoQuestion(pregunta: widget.pregunta.pregunta ?? 'NoData');

      case 'foto':
        return SelectPicture(
          pregunta: widget.pregunta,
          image: (image) {
            widget.photo(image);
          },
          mandatory: widget.mandatory,
        );

      case 'gps':
        return Gps(
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          answer: (position) {
            widget.positionGPS(position);
          },
          mandatory: widget.mandatory,
        );

      case 'tiempo':
        return MyTimer(
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          times: 2,
          mandatory: widget.mandatory,
        );

      case 'imagen':
        return SelectPicture(
          pregunta: widget.pregunta,
          image: (image) {
            widget.image(image);
          },
          mandatory: widget.mandatory,
        );

      case 'firma':
        return Signature(
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          getSignature: (signatureFile) {
            widget.signature(signatureFile);
          },
          mandatory: widget.mandatory,
        );

      case 'fecha':
        return PickerDT(
          getDateTime: (date) {
            widget.date(date);
          },
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          onlyDate: true,
          mandatory: widget.mandatory,
        );

      case 'fechaHora':
        return PickerDT(
          getDateTime: (dateTime) {
            widget.dateTime(dateTime);
          },
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          mandatory: widget.mandatory,
        );

      case 'hora':
        return PickerDT(
          getDateTime: (time) {
            widget.time(time);
          },
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          onlyTime: true,
          mandatory: widget.mandatory,
        );

      case 'scannerQR':
        return Scanner(
          pregunta: widget.pregunta.pregunta ?? 'NoData',
          mandatory: widget.mandatory,
        );
    }

    return Text(widget.pregunta.pregunta ?? 'NoData');
  }
}

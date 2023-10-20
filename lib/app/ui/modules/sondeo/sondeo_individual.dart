// ignore_for_file: avoid_print

import 'dart:io';
import 'package:emetrix_flutter/app/ui/modules/sondeo/widgets/bottom_buton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/widgets/custom_title.dart';
import 'components/components.dart';
import 'controller.dart';

class SingleSondeoPage extends ConsumerStatefulWidget {
  const SingleSondeoPage({
    super.key,
    required this.sondeoItem,
    required this.index,
    required this.store,
  });
  final RespM sondeoItem;
  final Store store;
  final int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SondeosBuilderState();
}

class _SondeosBuilderState extends ConsumerState<SingleSondeoPage> {
  double progressBar = 0; //* 1 = 100%
  int lenght = 0;
  int indexGlobal = 0;
  List<String> inputs = ['abierta', 'numerico', 'email', 'decimal'];
  List<String> radios = ['unicaRadio', 'sino'];
  List<String> images = ['fotoGuardarCopia', 'foto', 'imagen'];
  //* List Responses
  List<dynamic> responses = [];
  String? textResponse;
  String? radioResponse;
  File? imageResponse;
  File? signatureResponse; //*
  String? positionGPSResponse;
  DateTime? dateResponse;
  DateTime? dateTimeResponse;
  DateTime? timeResponse;

  @override
  Widget build(BuildContext context) {
    final finishedSections = ref.watch(finishedSondeos);

    return Scaffold(
        appBar: CustomTitle(title: widget.sondeoItem.sondeo),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: CustomScrollView(
            slivers: [
              // if (widget.sondeoItem.preguntas?[index].tipo ==
              //     'asistencia') {
              //   return MapView(store: widget.store);
              // } else {
              if (widget.sondeoItem.preguntas != null)
                SliverList.builder(
                    itemCount: widget.sondeoItem.preguntas?.length,
                    itemBuilder: (context, index) {
                      print(widget.sondeoItem.preguntas?[index].tipo);

                      return QuestionBuilder(
                        answer: (response) {
                          setState(() => textResponse = response);
                        },
                        answerRadio: (response) {
                          setState(() => radioResponse = response);
                        },
                        image: (image) {
                          setState(() => imageResponse = image);
                        },
                        positionGPS: (positionGPS) {
                          setState(() => positionGPSResponse = positionGPS);
                          print('GPS: $positionGPS');
                        },
                        signature: (signatureFile) {
                          setState(() => signatureResponse = signatureFile);
                          print('Signature: $signatureFile');
                        },
                        date: (date) {
                          //Get only date
                          setState(() => dateResponse = date);
                          print(
                              'Date: ${date?.day}/${date?.month}/${date?.year}');
                        },
                        dateTime: (dateTime) {
                          //Get date n time
                          setState(() => dateTimeResponse = dateTime);
                          print('DateTime: $dateTime');
                        },
                        time: (time) {
                          //Get only time
                          setState(() => timeResponse = time);
                          print('Time: ${time?.hour}:${time?.minute}');
                        },
                        index: index,
                        store: widget.store,
                        pregunta:
                            widget.sondeoItem.preguntas?[index] ?? Preguntas(),
                      );
                    })
              else
                SliverToBoxAdapter(
                    child: Center(child: Text('${widget.sondeoItem.linkWeb}'))),

              //*BUTTONS
              // if (lenght == 1 || lenght == 0)
              //   ButonDimentions(
              //     height: height,
              //     width: width,
              //     background: Colors.blue[700] ?? c.secondary.withOpacity(0.8),
              //     title: 'Finalizar',
              //     style: t.mediumLight,
              //     onTap: () => finalize(finishedSections),
              //     padding: EdgeInsets.only(bottom: size.height * 0.02),
              //   ),
              // else if (indexGlobal + 1 != lenght)
              //   ButonDimentions(
              //     height: height,
              //     width: width,
              //     background: Theme.of(context).dialogBackgroundColor,
              //     title: 'Next',
              //     style: t.mediumBlue,
              //     shadow: 2,
              //     onTap: () =>
              //         nextPage(lenght: lenght, progressValue: progressValue),
              //     padding: EdgeInsets.only(bottom: size.height * 0.02),
              //   )
              // else
              //   ButonDimentions(
              //     height: height,
              //     width: width,
              //     background: Colors.blue[700] ?? c.secondary.withOpacity(0.8),
              //     title: 'Finalizar',
              //     style: t.mediumLight,
              //     onTap: () => finalize(finishedSections),
              //     padding: EdgeInsets.only(bottom: size.height * 0.02),
              //   ),
            ],
          ),
        ),
        bottomNavigationBar: BottomButon(onTap: () {
          if (widget.index == 0) {
            finalize(finishedSections);
            return;
          }
          validateAllComponents();
        }
            // onTap: () => finalize(finishedSections),
            ));
  }

  Future<void> validateAllComponents() async {
    // final questionType = widget.sondeoItem.preguntas?[indexGlobal].tipo;
    FocusManager.instance.primaryFocus?.unfocus();
    await validateInputs();
    await validateRadios();
    await validateImages();

    // Extract data from others components

    // // Validate
    // if (inputs.contains(questionType)) {
    //   validateInputs();
    // }
    // //
    // else if (radios.contains(questionType)) {
    //   validateRadios();
    // }
    // //
    // else if (images.contains(questionType)) {
    //   print('Is an Image');
    //   validateImages();
    // }
    // //
    // else {
    //   print('Is other component');
    //   // Extract data from others components
    // }
  }

  Future validateImages() async {
    if (imageResponse == null) {
      print('returned');
      return;
    }
    setState(() {
      responses.add(imageResponse);
      printResponses();
      imageResponse = null;
    });
  }

  Future validateInputs() async {
    if (textResponse == null || textResponse!.isEmpty) {
      print('returned');
      return;
    }
    setState(() => responses.add(textResponse));
    setState(() {
      printResponses();
      textResponse = null;
    });
  }

  Future validateRadios() async {
    if (radioResponse == null) {
      return;
    }
    setState(() {
      responses.add(radioResponse);
      printResponses();
      radioResponse = null;
    });
  }

  void finalize(List<int> finishedSections) {
    //Save all progress and data to db

    if (!finishedSections.contains(widget.index) ||
        finishedSections.isEmpty ||
        finishedSections == []) {
      ref.read(finishedSondeos.notifier).state.add(widget.index);
    }
    ref
        .read(currentOptionProvider.notifier)
        .update((state) => state = widget.index + 1);
    ref.read(onlyFirstProvider.notifier).update((state) => false);

    printResponses();
    Future.delayed(const Duration(milliseconds: 800))
        .whenComplete(() => Navigator.pop(context));
  }

  void printResponses() {
    print('*************************');
    for (var element in responses) {
      print('Response: $element');
    }
    print('Total Responses: ${responses.length}');
    print('*************************');
  }

  //
}

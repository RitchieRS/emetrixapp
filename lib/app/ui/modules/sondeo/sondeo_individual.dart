// ignore_for_file: avoid_print

import 'dart:io';
import 'package:emetrix_flutter/app/core/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/widgets/bottom_buton.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/widgets/custom_title.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';
import 'components/components.dart';
import 'controller.dart';

class SingleSondeoPage extends ConsumerStatefulWidget {
  const SingleSondeoPage({
    super.key,
    required this.sondeoItem,
    required this.index,
    required this.stepsLenght,
    required this.store,
    required this.storeUuid,
  });
  final RespM sondeoItem;
  final Store2 store;
  final int index;
  final int stepsLenght;
  final String storeUuid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SondeosBuilderState();
}

class _SondeosBuilderState extends ConsumerState<SingleSondeoPage> {
  //* List Responses
  ResponseIndex? textResponse;
  ResponseIndex? numericResponse;
  ResponseIndex? decimalResponse;
  ResponseIndex? emailResponse;
  ResponseIndex? radioResponse;
  ResponseIndex? yesnoRadioResponse;
  ResponseIndex? multipleResponse;
  ResponseIndex? imageResponse;
  ResponseIndex? photoResponse;
  ResponseIndex? positionGPSResponse;
  ResponseIndex? signatureResponse;
  ResponseIndex? dateResponse;
  ResponseIndex? dateTimeResponse;
  ResponseIndex? timeResponse;
  //ThisSondeo
  List<QuestionResponse> questionsResponses = [];
  List<(String, int)> mandatoryQuestions = [];
  //Set color red
  List<bool> mandatoryComponents = [];
  bool validate = false;

  @override
  void initState() {
    super.initState();
    idenifyComponents();
  }

  @override
  Widget build(BuildContext context) {
    final finishedSections = ref.watch(finishedSondeos);

    return Scaffold(
        appBar: CustomTitle(title: widget.sondeoItem.sondeo),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: CustomScrollView(
            slivers: [
              if (widget.sondeoItem.preguntas != null)
                SliverList.builder(
                    itemCount: widget.sondeoItem.preguntas?.length,
                    itemBuilder: (context, index) {
                      print(mandatoryComponents);

                      return QuestionBuilder(
                        mandatory:
                            validate ? mandatoryComponents[index] : false,
                        answer: (response) {
                          setState(() {
                            validate = false;
                            textResponse =
                                ResponseIndex(index: index, response: response);
                          });
                        },
                        numeric: (response) {
                          setState(() {
                            validate = false;
                            numericResponse =
                                ResponseIndex(index: index, response: response);
                          });
                        },
                        decimal: (response) {
                          setState(() {
                            validate = false;
                            decimalResponse =
                                ResponseIndex(index: index, response: response);
                          });
                        },
                        email: (response) {
                          setState(() {
                            validate = false;
                            emailResponse =
                                ResponseIndex(index: index, response: response);
                          });
                        },
                        answerRadio: (response) {
                          setState(() {
                            validate = false;
                            radioResponse =
                                ResponseIndex(index: index, response: response);
                          });
                        },
                        yesnoRadio: (response) {
                          setState(() {
                            validate = false;
                            yesnoRadioResponse =
                                ResponseIndex(index: index, response: response);
                          });
                        },
                        selectionMultiple: (selectedItems) {
                          setState(() {
                            validate = false;
                            multipleResponse = ResponseIndex(
                                index: index,
                                response: selectedItems.toString());
                          });
                        },
                        image: (image) {
                          setState(() {
                            validate = false;
                            imageResponse = ResponseIndex(
                                index: index, response: image.toString());
                          });
                        },
                        photo: (photo) {
                          setState(() {
                            validate = false;
                            photoResponse = ResponseIndex(
                                index: index, response: photo.toString());
                          });
                        },
                        positionGPS: (positionGPS) {
                          setState(() {
                            validate = false;
                            positionGPSResponse = ResponseIndex(
                                index: index, response: positionGPS);
                          });
                        },
                        signature: (signatureFile) {
                          setState(() {
                            validate = false;
                            signatureResponse = ResponseIndex(
                                index: index,
                                response: signatureFile.toString());
                          });
                        },
                        date: (date) {
                          setState(() {
                            validate = false;
                            dateResponse = ResponseIndex(
                                index: index, response: date.toString());
                          });
                        },
                        dateTime: (dateTime) {
                          setState(() {
                            validate = false;
                            dateTimeResponse = ResponseIndex(
                                index: index, response: dateTime.toString());
                          });
                        },
                        time: (time) {
                          setState(() {
                            validate = false;
                            timeResponse = ResponseIndex(
                                index: index, response: time.toString());
                          });
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
            ],
          ),
        ),
        bottomNavigationBar: BottomButon(onTap: () async {
          if (widget.index == 0) {
            final image = await pickImage(ImageSource.camera);
            if (image != null) {
              await finalize(finishedSections);
              return;
            }
            return;
          }
          await validateAllComponents(finishedSections, ref);
          // finalize(finishedSections);
        }
            // onTap: () => finalize(finishedSections),
            ));
  }

  void idenifyComponents() {
    widget.sondeoItem.preguntas?.forEach((sondeo) {
      final index = widget.sondeoItem.preguntas?.indexOf(sondeo);
      questionsResponses.add(
        QuestionResponse(question: sondeo, response: null, indexSondeo: index!),
      );

      if (sondeo.obligatorio == 1) {
        mandatoryComponents.add(true);
        mandatoryQuestions.add((sondeo.tipo ?? '', index));
        return;
      }
      mandatoryComponents.add(false);
    });
  }

  Future<File?> pickImage(ImageSource source) async {
    try {
      final image2 = await ImagePicker().pickImage(source: source);
      if (image2 == null) return null;

      return File(image2.path);
    } on PlatformException catch (e) {
      debugPrint('Error extracting image:$e');
    }
    return null;
  }

  Future<void> validateAllComponents(
      List<int> finishedSections, WidgetRef ref) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, ResponseIndex?> typeResponses = {
      'abierta': textResponse,
      'numerico': numericResponse,
      'decimal': decimalResponse,
      'email': emailResponse,
      'unicaRadio': radioResponse,
      'sino': yesnoRadioResponse,
      'imagen': imageResponse,
      'foto': photoResponse,
      'fotoGuardarCopia': imageResponse,
      'multiple': multipleResponse,
      'gps': positionGPSResponse,
      'firma': signatureResponse,
      'fecha': dateResponse,
      'fechaHora': dateTimeResponse,
      'hora': timeResponse,
    };

    print('Obligatorias: $mandatoryQuestions');

    //Guardar las respuestas
    for (var question in questionsResponses) {
      final response = typeResponses[question.question?.tipo];
      if (response != null) {
        if (question.indexSondeo == response.index) {
          question.response = response.response;
        }
      }
    }
    setState(() {});
    for (var element in questionsResponses) {
      print('${element.question?.tipo}: ${element.response}');
    }

    int missingAnswers = 0;
    //Ver si las respuestas obligatorias estan vacias
    for (var questionMandatory in mandatoryQuestions) {
      for (var response in questionsResponses) {
        if (questionMandatory.$2 == response.indexSondeo) {
          if (response.response != null) {
            mandatoryComponents[response.indexSondeo!] = false;
            missingAnswers--;
          } else {
            mandatoryComponents[response.indexSondeo!] = true;
          }
          missingAnswers++;
        }
      }
    }

    if (missingAnswers != 0) {
      setState(() => validate = true);
      print(mandatoryComponents);
      await _showUnfinishedMessage(missingAnswers);
      return;
    }

    //Calculate progress
    int questionsResponded = 0;
    for (var element in questionsResponses) {
      if (element.response != null) {
        questionsResponded++;
      }
    }
    double progress =
        questionsResponded / (questionsResponses.length / 10) * 10;

    //Armar el pendiente y guardar todas las preguntas a la Base de datos
    print('Preguntas obligatorias contestadas');
    _showLoading();
    //Insert data to save0
    await ref.read(databaseProvider).updateSondeoFromStore(
          storeUuid: widget.storeUuid,
          stepIndex: widget.index,
          progress: progress,
          stepsLenght: widget.stepsLenght,
          sondeoQuestionResponses: questionsResponses,
        );
    // Navigator.pop(context);
    await Future.delayed(const Duration(milliseconds: 500)).whenComplete(() {
      Navigator.pop(context);
    });
    await finalize(finishedSections);
  }

  Future<void> _showUnfinishedMessage(int missingAnswers) async {
    await showMsj(
        context: context,
        title: 'Sondeo Incompleto',
        content: "Responde las $missingAnswers preguntas requeridas restantes",
        destructive: false,
        onlyOk: true,
        canTapOutside: true,
        buttonLabel: 'Ok');
  }

  Future<void> _showLoading() async {
    await showProgress(
      context: context,
      title: 'Guardando respestas',
      canTapOutside: false,
    );
  }

  Future<void> finalize(List<int> finishedSections) async {
    //Save all progress and data to db
    if (!finishedSections.contains(widget.index) || finishedSections.isEmpty) {
      ref.read(finishedSondeos.notifier).state.add(widget.index);
    }
    ref
        .read(currentOptionProvider.notifier)
        .update((state) => state = widget.index + 1);
    ref.read(onlyFirstProvider.notifier).update((state) => false);

    printResponses();
    await Future.delayed(const Duration(milliseconds: 800))
        .whenComplete(() => Navigator.pop(context));
  }

  void printResponses() {
    print('*************************');
    for (var element in questionsResponses) {
      print('Response: ${element.response}');
    }
    print('Total Responses: ${questionsResponses.length}');
    print('*************************');
  }

  //
}

// final class QuestionResponse {
//   QuestionResponse(
//       {required this.question, required this.index, required this.response});
//   RespM question;
//   dynamic response;
//   int index;
// }

final class ResponseIndex {
  ResponseIndex({required this.index, required this.response});
  int index;
  dynamic response;
}

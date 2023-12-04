import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/services/database/database.dart';
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
    required this.stepUuid,
  });
  final RespM sondeoItem;
  final Store2 store;
  final int index;
  final int stepsLenght;
  final String storeUuid;
  final String stepUuid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SondeosBuilderState();
}

class _SondeosBuilderState extends ConsumerState<SingleSondeoPage>
    with AutomaticKeepAliveClientMixin {
  SondeosFromStore? store;
  TextEditingController? answerController;
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
    getTempResponses();
    //Traer los datos de la bd, para pasarlos a los widgets hijos
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final finishedSections = ref.watch(finishedSondeos);

    return PopScope(
      onPopInvoked: (didPop) => onExit(didPop),
      child: Scaffold(
          appBar: CustomTitle(title: widget.sondeoItem.sondeo),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: CustomScrollView(
              slivers: [
                if (widget.sondeoItem.preguntas != null)
                  SliverList.builder(
                      itemCount: widget.sondeoItem.preguntas?.length,
                      itemBuilder: (context, index) {
                        // final item = widget.sondeoItem.preguntas?[index];

                        return QuestionBuilder(
                          mandatory:
                              validate ? mandatoryComponents[index] : false,
                          answerController: (controller) {
                            setState(() {
                              answerController = controller;
                            });
                          },
                          answer: (response) async {
                            setState(() {
                              validate = false;
                              textResponse = ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              );
                            });
                          },
                          numeric: (response) {
                            setState(() {
                              validate = false;
                              numericResponse = ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              );
                            });
                          },
                          decimal: (response) {
                            setState(() {
                              validate = false;
                              decimalResponse = ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              );
                            });
                          },
                          email: (response) {
                            setState(() {
                              validate = false;
                              emailResponse = ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              );
                            });
                          },
                          answerRadio: (response) {
                            setState(() {
                              validate = false;
                              radioResponse = ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              );
                            });
                          },
                          yesnoRadio: (response) {
                            setState(() {
                              validate = false;
                              yesnoRadioResponse = ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              );
                            });
                          },
                          selectionMultiple: (selectedItems) {
                            setState(() {
                              validate = false;
                              multipleResponse = ResponseIndex(
                                index: index,
                                response: selectedItems.toString(),
                                error: false,
                              );
                            });
                          },
                          image: (image) {
                            setState(() {
                              validate = false;
                              imageResponse = ResponseIndex(
                                index: index,
                                response: image.toString(),
                                error: false,
                              );
                            });
                          },
                          photo: (photo) {
                            setState(() {
                              validate = false;
                              photoResponse = ResponseIndex(
                                index: index,
                                response: photo.toString(),
                                error: false,
                              );
                            });
                          },
                          positionGPS: (positionGPS) {
                            setState(() {
                              validate = false;
                              positionGPSResponse = ResponseIndex(
                                index: index,
                                response: positionGPS,
                                error: false,
                              );
                            });
                          },
                          signature: (signatureFile) {
                            setState(() {
                              validate = false;
                              signatureResponse = ResponseIndex(
                                index: index,
                                response: signatureFile.toString(),
                                error: false,
                              );
                            });
                          },
                          date: (date) {
                            setState(() {
                              validate = false;
                              dateResponse = ResponseIndex(
                                index: index,
                                response: date.toString(),
                                error: false,
                              );
                            });
                          },
                          dateTime: (dateTime) {
                            setState(() {
                              validate = false;
                              dateTimeResponse = ResponseIndex(
                                index: index,
                                response: dateTime.toString(),
                                error: false,
                              );
                            });
                          },
                          time: (time) {
                            setState(() {
                              validate = false;
                              timeResponse = ResponseIndex(
                                index: index,
                                response: time.toString(),
                                error: false,
                              );
                            });
                          },
                          index: index,
                          store: widget.store,
                          pregunta: widget.sondeoItem.preguntas?[index] ??
                              Preguntas(),
                        );
                      })
                else
                  SliverToBoxAdapter(
                      child:
                          Center(child: Text('${widget.sondeoItem.linkWeb}'))),
              ],
            ),
          ),
          bottomNavigationBar: BottomButon(onTap: () async {
            await validateAllComponents(finishedSections, ref);
          })),
    );
  }

  void onExit(bool didpop) async {
    final store = await ref
        .read(databaseProvider)
        .getStoreByUuid(storeUuid: widget.storeUuid);
    if (store?.storeSteps == null) {
      logger.i('No hay pasos');
      //save responses from this step
      buildResponses();
      await ref.read(databaseProvider).saveStepData(
            storeUuid: widget.storeUuid,
            progress: 0,
            stepsLenght: widget.stepsLenght,
            stepUuid: widget.stepUuid,
            sondeoQuestionResponses: questionsResponses,
          );
      logger.i('guardamos el paso actual');
      return;
    }

    logger.i('Si hay pasos');
    store?.storeSteps?.forEach((element) async {
      //identify every list
      if (element.stepUuid == widget.stepUuid) {
        //update responses from this step
        buildResponses();
        await ref.read(databaseProvider).updateStepData(
            sondeoQuestionResponses: questionsResponses,
            storeUuid: widget.storeUuid,
            stepUuid: widget.stepUuid);
        logger.i('Actualizamos las respuestas que hay');
        return;
      }
    });

    //save responses from this step
    buildResponses();
    await ref.read(databaseProvider).saveStepData(
          storeUuid: widget.storeUuid,
          progress: 0,
          stepsLenght: widget.stepsLenght,
          stepUuid: widget.stepUuid,
          sondeoQuestionResponses: questionsResponses,
        );
    logger.i('guardamos el paso actual');
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

  Future<void> getTempResponses() async {
    store = await ref
        .read(databaseProvider)
        .getStoreByUuid(storeUuid: widget.storeUuid);
    setState(() {});

    if (store?.storeSteps != null) {
      try {
        // final responses = store?.storeSteps
        //     ?.firstWhere((element) => element.stepUuid == widget.stepUuid);

        SondeoCollection? responses;

        store?.storeSteps?.forEach((element) {
          if (element.stepUuid == widget.stepUuid) {
            setState(() {
              responses = element;
            });
          }
        });

        if (responses != null) {
          widget.sondeoItem.preguntas?.forEach((element2) async {
            final index = widget.sondeoItem.preguntas?.indexOf(element2);
            final element = responses?.sondeos?[index!];
            // print(element?.response);

            if (element2.uuid == element?.question?.uuid) {
              print('--------------');
              print(element2.tipo);
              print(element2.uuid);
              print(element?.question?.tipo);
              print(element?.question?.uuid);
              print(element?.response);
              print('--------------');
              //Identificar el tipo de componente
              // await Future.delayed(const Duration(milliseconds: 800));

              // print(element?.response); // Esta es la respuesta guardada anteriormente
              // print(element2.tipo);
              // print(answerController?.text); //Este es el valor del textfield
              if (element?.response != null) {
                indentifyHints(element?.response, element2.tipo!);
                setState(() {});
              }
            }
          });
        } else {
          logger.i('Aun no esta en bd jsahjsjs');
        }
      } catch (error) {
        logger.e(error);
        return;



      }
    }
  }

  void indentifyHints(String? response, String? type) {
    switch (type) {
      case 'abierta':
        if (response != null) {
          setState(() => answerController?.text = response);
        }
    }
  }

  void buildResponses() {
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
  }

  Future<void> validateAllComponents(
      List<int> finishedSections, WidgetRef ref) async {
    FocusManager.instance.primaryFocus?.unfocus();
    buildResponses();

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
    await ref.read(databaseProvider).saveStepData(
          storeUuid: widget.storeUuid,
          progress: progress,
          stepsLenght: widget.stepsLenght,
          stepUuid: widget.stepUuid,
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
    if (kDebugMode) {
      debugPrint('*************************');
      for (var element in questionsResponses) {
        debugPrint('Response: ${element.response}');
      }
      debugPrint('Total Responses: ${questionsResponses.length}');
      debugPrint('*************************');
    }
  }

  @override
  bool get wantKeepAlive => true;

  //
}

final class ResponseIndex {
  ResponseIndex({
    required this.index,
    required this.response,
    required this.error,
  });
  int index;
  bool error;
  dynamic response;
}

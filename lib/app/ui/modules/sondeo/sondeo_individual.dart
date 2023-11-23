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
  });
  final RespM sondeoItem;
  final Store2 store;
  final int index;
  final int stepsLenght;
  final String storeUuid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SondeosBuilderState();
}

class _SondeosBuilderState extends ConsumerState<SingleSondeoPage>
    with AutomaticKeepAliveClientMixin {
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
      onPopInvoked: (didPop) async {
        final storeExist = await ref
            .read(databaseProvider)
            .existStoreData(storeUuid: widget.storeUuid);
        if (storeExist) {
          //update values
          buildResponses();
          // -->
        }
        //save values
        buildResponses();
        await ref.read(databaseProvider).updateSondeoFromStore(
              storeUuid: widget.storeUuid,
              stepIndex: widget.index,
              progress: 0,
              stepsLenght: widget.stepsLenght,
              sondeoQuestionResponses: questionsResponses,
            );
        // return Future.value(true);
      },
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
                          answerValue: textResponse?.response,
                          answer: (response, error) async {
                            // if (error) {
                            //   await showMsj(
                            //       context: context,
                            //       title: 'Error',
                            //       content:
                            //           'Respuesta invalida en ${item?.pregunta}',
                            //       destructive: false,
                            //       onlyOk: true,
                            //       buttonLabel: 'Ok');
                            //   return;
                            // }
                            print(response);
                            setState(() {
                              validate = false;
                              textResponse = ResponseIndex(
                                index: index,
                                response: response,
                                error: error,
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
    final store = await ref
        .read(databaseProvider)
        .getStoreByUuid(storeUuid: widget.storeUuid);

    final responses = store?.storeSteps?[widget.index];
    print('Si trae las respuestas de este paso');

    responses?.sondeos?.forEach((element) {
      if (textResponse?.index == element.indexSondeo) {
        print('este sondeo coincide');
        setState(() {});
      }
    });
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

import 'dart:io';

import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/services/notifications/notifications.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/controller.dart';
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
    with WidgetsBindingObserver {
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
  bool startTextAsignation = false;
  final ids = <(String, String)>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    idenifyComponents();
    getTempResponses();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      debugPrint('APP ------> RUNING ON THE BACKK');

      NotificationService().showNotification(
        title: 'Sondeo en Progreso',
        body: 'NO ELIMINES LA APP',
      );

      //
    } else if (state == AppLifecycleState.resumed) {
      debugPrint('APP ------> RUNING ON MAIN');

      //
    } else if (state == AppLifecycleState.inactive) {
      debugPrint('APP ------> RUNING BELOW A MESSAGE');
    } else if (state == AppLifecycleState.detached) {
      debugPrint('APP ------> KILLED');
    }
  }

  @override
  Widget build(BuildContext context) {
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

                        print(widget.sondeoItem.preguntas?[index].tipo);

                        return QuestionBuilder(
                          mandatory:
                              validate ? mandatoryComponents[index] : false,
                          answerController: (controller, uuid) {
                            // setState(() => answerController = controller);
                            // setState(() {
                            //   validate = false;
                            //   textResponse = ResponseIndex(
                            //     index: index,
                            //     response: answerController?.text,
                            //     error: false,
                            //   );
                            // });
                            // if (!startTextAsignation) return;

                            if (uuid ==
                                widget.sondeoItem.preguntas?[index].uuid) {
                              // if (textResponse != null) {
                              setState(() => answerController = controller);
                              //   print('RESPONSE');
                              //   print(textResponse?.response);

                              //   setState(() => controller.text =
                              //       textResponse?.response.toString() ?? '');
                              // }
                              // setState(() => controller?.text =
                              //     textResponse?.response.toString() ?? '');
                            }
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

  void _disposeControllers() {
    final text = ['abierta', 'numerico', 'email', 'decimal'];

    for (var id in ids) {
      //Dispose text
      if (text.contains(id.$2)) {
        ref.watch(textEditingControllerProvider(int.parse(id.$1))).clear();
      }
    }
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
//_stopwatch = ref.watch(stopwatchProviderFamily(int.parse(widget.preguntawid.id ?? '0')));
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
      } else {
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
    });
  }

  void idenifyComponents() {
    widget.sondeoItem.preguntas?.forEach((sondeo) {
      final index = widget.sondeoItem.preguntas?.indexOf(sondeo);
      questionsResponses.add(
        QuestionResponse(question: sondeo, response: null, indexSondeo: index!),
      );
      setState(() {});

      if (sondeo.obligatorio == 1) {
        mandatoryComponents.add(true);
        mandatoryQuestions.add((sondeo.tipo ?? '', index));
        return;
      }
      mandatoryComponents.add(false);
      ids.add((sondeo.id!, sondeo.tipo!));
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
              print(index);
              print(element2.tipo);
              print(element2.uuid);
              print(element?.question?.tipo);
              print(element?.question?.uuid);
              print(element?.response);
              print('--------------');
              //Identificar el tipo de componente
              if (element?.response != null) {
                indentifyHints(element?.response, element2.tipo!, index!);
                setState(() {});
              }
            }
          });
        } else {
          logger.i('Aun no esta en bd');
        }
      } catch (error) {
        logger.e(error);
        return;
      }
    }
  }

  void indentifyHints(String? response, String? type, int index) {
    switch (type) {
      case 'abierta':
        if (response != null) {
          setState(() => answerController?.text = response);

          // setState(() => textResponse = ResponseIndex(
          //       index: index,
          //       response: response,
          //       error: false,
          //     ));
        }
    }
  }

  void buildResponses() async{
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

    for (var question in questionsResponses) {
      
      final response = typeResponses[question.question?.tipo];
       logger.e("Respuesta pas1: ${question.response}");
      if (response != null) {
        if (question.indexSondeo == response.index && question.question?.tipo != 'foto') {
          question.response = response.response;
        }
        else{
          var image = ref
        .watch(imageFileProviderFamily(int.parse(question.question?.id ?? '0')));
          question.response = image?.file?.path;
        }
      }
    }

    //Guardar las respuestas
    setState(() {
    
    });
  }

  Future<void> validateAllComponents(
      List<int> finishedSections, WidgetRef ref) async {
    final navigator = Navigator.of(context);
    FocusManager.instance.primaryFocus?.unfocus();
    buildResponses();

    int missingAnswers = 0;
    //Ver si las respuestas obligatorias estan vacias
    for (var questionMandatory in mandatoryQuestions) {
      for (var response in questionsResponses) {
        logger.e("mandatiorios:${response.response}");
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
    print('Preguntas obligatorias contestadas');

    _showLoading();
    await ref.read(databaseProvider).saveStepData(
          storeUuid: widget.storeUuid,
          progress: progress,
          stepsLenght: widget.stepsLenght,
          stepUuid: widget.stepUuid,
          sondeoQuestionResponses: questionsResponses,
        );
    await Future.delayed(const Duration(seconds: 2));
    navigator.pop();
    _disposeControllers();
    removeProviderIndex(widget.sondeoItem.preguntas);
    await finalize(finishedSections);
  }

  void removeProviderIndex(List<Preguntas>? preguntas){
  
   
    for(var pregunta in preguntas!){
      
       if(pregunta.tipo == 'abierta' || pregunta.tipo == 'numerico' ||pregunta.tipo == 'decimal' || pregunta.tipo == 'email' ) {
         var provider =  ref.watch(textEditingControllerProvider( int.parse(pregunta.id ?? '0')));
         if(provider.value.text != '' ){
             provider.value = TextEditingValue.empty;
         }
       }
       logger.i("Tipopregunta: ${pregunta.tipo}");
       if(pregunta.tipo == 'foto' || pregunta.tipo ==  'fotoGuardarCopia' || pregunta.tipo ==  'imagen'){
        var provider  =  ref.watch(imageFileProviderFamily(int.parse(pregunta.id ?? '0')));
       
          if(provider?.file != null ){
            provider?.file = null;
          }
       }

       if(pregunta.tipo == 'tiempo'){
        logger.d("MATAR TIEMPO");
        var provider = ref.watch(stopwatchProviderFamily(int.parse(pregunta.id ?? '0')));
          if(provider.isRunning() ){
            provider.stop();
          }
       }

    }

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
      title: 'Guardando respuestas',
      canTapOutside: false,
    );
  }

  Future<void> finalize(List<int> finishedSections) async {
    //Save all progress and data to db
    if (!finishedSections.contains(widget.index) || finishedSections.isEmpty) {
      var listAux = ref.read(finishedSondeos.notifier).state;
      listAux = listAux.toList();
      listAux.add(widget.index);
      ref.read(finishedSondeos.notifier).update((state) => listAux);

      final state = StepsState(completedSections: listAux, firstOption: false);
      await ref
          .read(databaseProvider)
          .saveStepsState(storeUuid: widget.storeUuid, state: state);

      //// ref.read(finishedSondeos.notifier).state.add(widget.index);
    }
    ref.read(onlyFirstProvider.notifier).update((state) => false);

    printResponses();
    Navigator.pop(context);
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

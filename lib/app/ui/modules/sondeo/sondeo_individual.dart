import 'dart:io';

import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/pendientes.dart';
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
import 'package:path_provider/path_provider.dart';
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
  List<ResponseIndex?> textResponses = [];
  List<ResponseIndex?> numericResponses = [];
  List<ResponseIndex?> decimalResponses = [];
  List<ResponseIndex?> emailResponses = [];
  List<ResponseIndex?> radioResponses = [];
  List<ResponseIndex?> yesnoRadioResponses = [];
  List<ResponseIndex?> multipleResponses = [];
  List<ResponseIndex?> imageResponses = [];
  List<ResponseIndex?> photoResponses = [];
  List<ResponseIndex?> fotoGuardarCopiaResponses = [];
  List<ResponseIndex?> carruselResponses = [];
  List<ResponseIndex?> positionGPSResponses = [];
  List<ResponseIndex?> signatureResponses = [];
  List<ResponseIndex?> dateResponses = [];
  List<ResponseIndex?> dateTimeResponses = [];
  List<ResponseIndex?> timeResponses = [];
  List<ResponseIndex?> escanerResponses = [];
  List<ResponseIndex?> tiempoResponses = [];
  List<ResponseIndex?> areasResponses = [];
  List<ResponseIndex?> areasMultiplesResponses = [];
  //ThisSondeo
  List<QuestionResponse> questionsResponses = [];
  List<(String, int)> mandatoryQuestions = [];
  //Set color red
  List<bool> mandatoryComponents = [];
  bool validate = false;
  bool startTextAsignation = false;
  final ids = <(String, String)>[];
  final List<Respuestas> responses = [];
  List<Preguntas> preguntasfn = [];
  List<Preguntas> preguntasdep = [];

  @override
  void initState() {
    super.initState();
    preguntasOrganizer();
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

    QuestionContain containsQuestion(List<Preguntas> q1, idPregunta) {
      for (var i = 0; i < q1.length; i++) {
        logger.i("IsOn ${q1[i].dependePregunta} y $idPregunta");
        if (q1[i].dependePregunta == idPregunta) {
          return QuestionContain(i, true);
        }
      }
      return QuestionContain(0, false);
    }

    void updateData(String? idPregunta, String? response) {
      var checkIsOn = containsQuestion(preguntasfn, idPregunta);
      if (checkIsOn.yesornot == true) {
        preguntasfn.removeAt(checkIsOn.position);
      }
      //logger.i("Id from CB $idPregunta y $response");
      var checkPreguntas = preguntasdep
          .where((p) =>
              p.dependePregunta == idPregunta && p.dependeRespuesta == response)
          .toList();
      //logger.i("CB ${checkPreguntas.toList()}");
      if (checkPreguntas.isNotEmpty) {
        preguntasfn.add(checkPreguntas[0]);
        preguntasfn.sort((a, b) =>
            int.parse(a.ordenI ?? '0').compareTo(int.parse(b.ordenI ?? '1')));
      }
      setState(() => {});
    }

    return PopScope(
      onPopInvoked: (didPop) => onExit(didPop),
      child: Scaffold(
          appBar: CustomTitle(title: widget.sondeoItem.sondeo),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: CustomScrollView(
              slivers: [
                if (preguntasfn.isNotEmpty)
                  SliverList.builder(
                      itemCount: preguntasfn.length,
                      itemBuilder: (context, index) {
                        // final item = widget.sondeoItem.preguntas?[index];

                        logger.i("${preguntasfn[index].tipo}" +
                            " su index es $index");

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

                            if (uuid == preguntasfn[index].uuid) {
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
                          callback: updateData,
                          answer: (response) async {
                            setState(() {
                              validate = false;
                              textResponses.add(ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              ));
                            });
                          },
                          numeric: (response) {
                            setState(() {
                              validate = false;
                              numericResponses.add(ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              ));
                            });
                          },
                          decimal: (response) {
                            setState(() {
                              validate = false;
                              decimalResponses.add(ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              ));
                            });
                          },
                          email: (response) {
                            setState(() {
                              validate = false;
                              emailResponses.add(ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              ));
                            });
                          },
                          answerRadio: (response) {
                            setState(() {
                              validate = false;
                              radioResponses.add(ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              ));
                            });
                          },
                          yesnoRadio: (response) {
                            setState(() {
                              validate = false;
                              yesnoRadioResponses.add(ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              ));
                            });
                          },
                          selectionMultiple: (selectedItems) {
                            setState(() {
                              validate = false;
                              multipleResponses.add(ResponseIndex(
                                index: index,
                                response: selectedItems.toString(),
                                error: false,
                              ));
                            });
                          },
                          image: (image) {
                            setState(() {
                              validate = false;
                              imageResponses.add(ResponseIndex(
                                index: index,
                                response: image,
                                error: false,
                              ));
                            });
                          },
                          foto: (photo) {
                            setState(() {
                              validate = false;
                              photoResponses.add(ResponseIndex(
                                index: index,
                                response: photo,
                                error: false,
                              ));
                            });
                          },
                          carrusel: (response) {
                            setState(() {
                              validate = false;
                              carruselResponses.add(ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              ));
                            });
                          },
                          positionGPS: (positionGPS) {
                            setState(() {
                              validate = false;
                              positionGPSResponses.add(ResponseIndex(
                                index: index,
                                response: positionGPS,
                                error: false,
                              ));
                            });
                          },
                          signature: (signatureFile) {
                            setState(() {
                              validate = false;
                              signatureResponses.add(ResponseIndex(
                                index: index,
                                response: signatureFile.toString(),
                                error: false,
                              ));
                            });
                          },
                          date: (date) {
                            setState(() {
                              validate = false;
                              dateResponses.add(ResponseIndex(
                                index: index,
                                response: date.toString(),
                                error: false,
                              ));
                            });
                          },
                          dateTime: (dateTime) {
                            setState(() {
                              validate = false;
                              dateTimeResponses.add(ResponseIndex(
                                index: index,
                                response: dateTime.toString(),
                                error: false,
                              ));
                            });
                          },
                          time: (time) {
                            setState(() {
                              validate = false;
                              timeResponses.add(ResponseIndex(
                                index: index,
                                response: time.toString(),
                                error: false,
                              ));
                            });
                          },
                          tiempo: (tiempo) {
                            setState(() {
                              validate = false;
                              tiempoResponses.add(ResponseIndex(
                                index: index,
                                response: tiempo,
                                error: false,
                              ));
                            });
                          },
                          areas: (response) {
                            setState(() {
                              validate = false;
                              areasResponses.add(ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              ));
                            });
                          },
                          areasMultiples: (response) {
                            setState(() {
                              validate = false;
                              areasMultiplesResponses.add(ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              ));
                            });
                          },
                          escaner: (response) {
                            setState(() {
                              validate = false;
                              escanerResponses.add(ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              ));
                            });
                          },
                          fotoGuardarCopia: (response) {
                            setState(() {
                              validate = false;
                              fotoGuardarCopiaResponses.add(ResponseIndex(
                                index: index,
                                response: response,
                                error: false,
                              ));
                            });
                          },
                          index: index,
                          store: widget.store,
                          pregunta: preguntasfn[index],
                          preguntasdep: preguntasdep,
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

  List<Preguntas> preguntasOrganizer() {
    List<Preguntas>? preguntasorigen = widget.sondeoItem.preguntas;

    for (var p = 0; p < preguntasorigen!.length; p++) {
      if (preguntasorigen[p].dependePregunta == "" &&
          preguntasorigen[p].dependeRespuesta == "") {
        preguntasorigen[p].ordenI = p.toString();
        preguntasfn.add(preguntasorigen[p]);
      } else {
        preguntasorigen[p].ordenI = p.toString();
        preguntasdep.add(preguntasorigen[p]);
      }
    }

    preguntasdep.forEach((p) {
      logger.i("Preguntas:${p.id} y ${p.dependePregunta}");
    });
    return preguntasfn;
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
    logger.i('RespM ${widget.sondeoItem}');
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
      //Build Pending
    });
  }

  void idenifyComponents() {
    for (var sondeo in preguntasfn) {
      final index = preguntasfn.indexOf(sondeo);
      questionsResponses.add(
        QuestionResponse(question: sondeo, response: null, indexSondeo: index),
      );
      setState(() {});

      if (sondeo.obligatorio == 1) {
        mandatoryComponents.add(true);
        mandatoryQuestions.add((sondeo.tipo ?? '', index));
        continue;
      }
      mandatoryComponents.add(false);
      ids.add((sondeo.id!, sondeo.tipo!));
    }
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

  //Aquí empiezan los metodos para construir las respuestas
  void buildResponses() {
    Map<String, List<ResponseIndex?>> typeResponses = {
      'abierta': textResponses,
      'numerico': numericResponses,
      'decimal': decimalResponses,
      'email': emailResponses,
      'unicaRadio': radioResponses,
      'sino': yesnoRadioResponses,
      'imagen': imageResponses,
      'foto': photoResponses,
      'carrusel': carruselResponses,
      'fotoGuardarCopia': fotoGuardarCopiaResponses,
      'multiple': multipleResponses,
      'gps': positionGPSResponses,
      'firma': signatureResponses,
      'fecha': dateResponses,
      'fechaHora': dateTimeResponses,
      'hora': timeResponses,
      'tiempo': tiempoResponses,
      'areas': areasResponses,
      'areasMultiples': areasMultiplesResponses,
      'scannerQR': escanerResponses,
    };

    for (var question in questionsResponses) {
      final responsesMap = typeResponses[question.question?.tipo];
      if (responsesMap != null) {
        for (var response in responsesMap) {
          if (response?.index == question.indexSondeo) {
            if (_isSpecialResponse(question)) {
              _handleSpecialResponse(question, response);
            } else {
              _handleStandardResponse(question, response);
              question.response = response?.response.toString();
              _addOrUpdateResponse(question.question!.id!, question.response!,
                  question.question!.tipo!);
            }
          }
        }
      }
    }

    logger.f(responses.toString());

    setState(() {});
  }

  bool _isSpecialResponse(var question) {
    return question.question!.tipo == 'foto' ||
        question.question!.tipo == 'firma' ||
        question.question!.tipo == 'imagen' ||
        question.question!.tipo == 'fotoGuardarCopia' ||
        question.question!.tipo == 'carrusel';
  }

  void _handleStandardResponse(var question, ResponseIndex? response) {
    if (question.question!.tipo == 'areas' ||
        question.question!.tipo == 'areasMultiples') {
      var image =
          ref.watch(imageFileProviderFamily(int.parse(question.question!.id!)));
      if (image != null) {
        _addOrUpdateResponse(
            question.question!.id!, image.file!.path.toString(), 'foto');
      }
    }
    question.response = response?.response.toString();
  }

  void _handleSpecialResponse(var question, ResponseIndex? response) {
    File image = File(response!.response.toString());
    if (image.path != "") {
      if (question!.question.tipo == 'fotoGuardarCopia') {
        saveImageGallery(image.path);
      }
      if (question!.question.tipo == 'carrusel') {
        _addResponse(question!.question.id, response.response.toString(),
            question!.question.tipo);
      } else {
        _addOrUpdateResponse(question.question!.id!, image.path.toString(),
            question.question!.tipo);
        question.response = image.path.toString();
      }
    }
  }

  void _addOrUpdateResponse(String idPregunta, String respuesta, String tipo) {
    final resp = Respuestas(
      idPregunta: idPregunta,
      respuesta: respuesta,
      tipo: tipo,
      size: "",
    );

    int index = responses
        .indexWhere((r) => r.idPregunta == idPregunta && r.tipo == tipo);

    if (index != -1) {
      responses[index] = resp;
    } else {
      if (resp.respuesta != null) {
        responses.add(resp);
      }
    }
  }

  void _addResponse(String idPregunta, String respuesta, String tipo) {
    final resp = Respuestas(
      idPregunta: idPregunta,
      respuesta: respuesta,
      tipo: tipo,
      size: "",
    );

    if (resp.respuesta!.isNotEmpty) {
      responses.add(resp);
    }
  }
  //Aquí terminan las funciones para construir las respuestas

  Future<void> validateAllComponents(
      List<int> finishedSections, WidgetRef ref) async {
    final navigator = Navigator.of(context);
    FocusManager.instance.primaryFocus?.unfocus();
    buildResponses();

    int missingAnswers = 0;
    QuestionResponse defaultResponse = QuestionResponse();

    for (var questionMandatory in mandatoryQuestions) {
      var response = questionsResponses.firstWhere(
        (r) => r.indexSondeo == questionMandatory.$2,
        orElse: () => defaultResponse,
      );
      if (response != null &&
          response.response != null &&
          response.response!.isNotEmpty) {
        mandatoryComponents[response.indexSondeo!] = false;
      } else {
        mandatoryComponents[response.indexSondeo ?? 0] = true;
        missingAnswers++;
      }
    }

    if (missingAnswers != 0) {
      setState(() => validate = true);
      print(mandatoryComponents);
      await _showUnfinishedMessage(missingAnswers);
      return;
    }

    // Calculate progress
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
    await ref.read(sondeoController.notifier).buildPending(
        widget.sondeoItem, widget.store, ref, responses, widget.storeUuid);
    navigator.pop();
    _disposeControllers();
    removeProviderIndex(widget.sondeoItem.preguntas);
    await finalize(finishedSections);
  }

  void removeProviderIndex(List<Preguntas>? preguntas) {
    for (var pregunta in preguntas!) {
      if (pregunta.tipo == 'abierta' ||
          pregunta.tipo == 'numerico' ||
          pregunta.tipo == 'decimal' ||
          pregunta.tipo == 'email') {
        var provider = ref.watch(
            textEditingControllerProvider(int.parse(pregunta.id ?? '0')));
        if (provider.value.text != '') {
          provider.value = TextEditingValue.empty;
        }
      }
      logger.i("Tipopregunta: ${pregunta.tipo}");
      if (pregunta.tipo == 'foto' ||
          pregunta.tipo == 'fotoGuardarCopia' ||
          pregunta.tipo == 'imagen') {
        var provider =
            ref.watch(imageFileProviderFamily(int.parse(pregunta.id ?? '0')));
        if (provider?.file != null) {
          provider?.file = null;
        }
      }

      if (pregunta.tipo == 'tiempo') {
        logger.d("MATAR TIEMPO");
        var provider =
            ref.watch(stopwatchProviderFamily(int.parse(pregunta.id ?? '0')));
        if (provider.isRunning()) {
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

  Future<void> saveImageGallery(String imagePath) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;

      final File imageFile = File(imagePath);
      String fileName = imageFile.path.split('/').last;
      final bytes = await imageFile.readAsBytes();

      final File newImageFile = File('$path/$fileName');

      await newImageFile.writeAsBytes(bytes);

      logger.i('Imagen guardada en: ${newImageFile.path}');
    } catch (e) {
      logger.i('Error al guardar la imagen: $e');
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

class QuestionContain {
  final int position;
  final bool yesornot;

  QuestionContain(this.position, this.yesornot);
}

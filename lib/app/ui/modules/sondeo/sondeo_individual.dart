// ignore_for_file: avoid_print

import 'package:emetrix_flutter/app/ui/modules/sondeo/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

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
  final PageController pageController = PageController();
  double progressBar = 0; //* 1 = 100%
  int lenght = 0;
  int indexGlobal = 0;
  List<String> inputs = ['abierta', 'numerico', 'email', 'decimal'];
  List<String> radios = ['unicaRadio', 'sino'];
  //* List Responses
  List<dynamic> responses = [];
  String? textResponse;
  String? radioResponse;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int lenght =
        widget.sondeoItem.preguntas?.length ?? 0; //*Returns length from 1
    final double progressValue = 1 / lenght;
    final finishedSections = ref.watch(finishedSondeos);
    final height = size.height * 0.06;
    final width = size.width * 0.9;

    return Scaffold(
      appBar: CustomTitle(title: widget.sondeoItem.sondeo),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          children: [
            Container(
              color: c.surface,
              child: Padding(
                  padding:
                      const EdgeInsets.only(left: 14.0, right: 14, bottom: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      tween: Tween<double>(
                        begin: 0,
                        end: progressBar,
                      ),
                      builder: (context, value, _) => LinearProgressIndicator(
                          value: value,
                          minHeight: size.height * 0.008,
                          color: c.primary,
                          backgroundColor:
                              Theme.of(context).hintColor.withOpacity(0.2)),
                    ),
                  )),
            ),
            //* CONTENT ----
            if (widget.sondeoItem.preguntas != null)
              Expanded(
                child: Container(
                  color: c.surface,
                  child: PageView.builder(
                      controller: pageController,
                      allowImplicitScrolling: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.sondeoItem.preguntas?.length,
                      onPageChanged: (value) {
                        setState(() => indexGlobal = value);
                      },
                      itemBuilder: (context, index) {
                        if (widget.sondeoItem.preguntas?[index].tipo ==
                            'asistencia') {
                          return MapView(store: widget.store);
                        } else {
                          return QuestionBuilder(
                            answer: (response) {
                              setState(() => textResponse = response);
                            },
                            answerRadio: (response) {
                              setState(() => radioResponse = response);
                            },
                            index: index,
                            store: widget.store,
                            pregunta: widget.sondeoItem.preguntas?[index] ??
                                Preguntas(),
                          );
                        }
                      }),
                ),
              )
            else
              Center(child: Text('${widget.sondeoItem.linkWeb}')),

            lenght != 0
                ? Padding(
                    padding: EdgeInsets.only(top: size.height * 0.01),
                    child: Container(
                        height: size.height * 0.03,
                        color: c.surface,
                        child: Text(
                          'Pregunta ${indexGlobal + 1} de ${lenght.ceil()} \n',
                          style: t.textDisabled,
                        )),
                  )
                : const SizedBox(),

            //*BUTTONS
            if (lenght == 1 || lenght == 0)
              ButonDimentions(
                height: height,
                width: width,
                background: c.onTertiary,
                title: 'Finalizar',
                style: t.mediumLight,
                onTap: () => finalize(finishedSections),
                padding: EdgeInsets.only(bottom: size.height * 0.02),
              )
            else if (indexGlobal + 1 != lenght)
              ButonDimentions(
                height: height,
                width: width,
                background: Theme.of(context).dialogBackgroundColor,
                title: 'Next',
                style: t.mediumBlue,
                shadow: 2,
                onTap: () =>
                    nextPage(lenght: lenght, progressValue: progressValue),
                padding: EdgeInsets.only(bottom: size.height * 0.02),
              )
            else
              ButonDimentions(
                height: height,
                width: width,
                background: Colors.blue[700] ?? c.secondary.withOpacity(0.8),
                title: 'Finalizar',
                style: t.mediumLight,
                onTap: () => finalize(finishedSections),
                padding: EdgeInsets.only(bottom: size.height * 0.02),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> nextPage({
    required int lenght,
    required double progressValue,
  }) async {
    final questionType = widget.sondeoItem.preguntas?[indexGlobal].tipo;
    FocusManager.instance.primaryFocus?.unfocus();

    print('--------------------------------------------------------------\n');

    // Validate
    // If TextField
    if (inputs.contains(questionType)) {
      print('Is an Input');
      validateInputs(progressValue);
    }
    // If Radios
    else if (radios.contains(questionType)) {
      print('Is an Radio');
      validateRadios(progressValue);
    } else {
      // Extract data from others components
      print('Is other component');
      // await goNextQuestion(progressValue);
    }
    //
    print('--------------------------------------------------------------\n');
  }

  Future validateInputs(double progressValue) async {
    if (textResponse == null || textResponse!.isEmpty) {
      print('returned');
      return;
    }

    setState(() => responses.add(textResponse));
    await goNextQuestion(progressValue);
    setState(() {
      printResponses();
      textResponse = null;
    });
  }

  Future validateRadios(double progressValue) async {
    if (radioResponse == null) {
      return;
    }

    setState(() => responses.add(radioResponse));
    await goNextQuestion(progressValue);
    setState(() {
      printResponses();
      radioResponse = null;
    });
  }

  bool isLastPage(double currentPage) {
    return currentPage.abs() == widget.sondeoItem.preguntas!.length - 1;
  }

  Future<void> goNextQuestion(double progressValue) async {
    final progressBarStillLoading = progressBar != 1;

    if (progressBarStillLoading) {
      print('INDEX GLOBAL: $indexGlobal');
      setState(() => progressBar += progressValue);

      await pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
      setState(() {});
    }
  }

  void finalize(List<int> finishedSections) {
    //* UI ProgressBar
    if (progressBar != 1) {
      setState(() => progressBar = 1);
    }

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

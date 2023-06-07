// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
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

class _SondeosBuilderState extends ConsumerState<SingleSondeoPage>
    with AutomaticKeepAliveClientMixin {
  final PageController pageController = PageController();
  double progressBar = 0; //* 1 = 100%
  int lenght = 0;
  List<TextEditingController> textControllers = [];
  int inputIndex = 1;
  int indexGlobal = 0;
  List<String> inputs = ['abierta', 'numerico', 'email', 'decimal'];

  //* List Responses
  List<dynamic> responses = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getControllersLenght(widget.sondeoItem);
      // ref
      //     .read(validatorProvider.notifier)
      //     .getLenght(lenght: widget.sondeoItem.preguntas?.length ?? 0);
    });
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    final buttonStyle = OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size(size.width * 0.35, size.height * 0.06));
    int lenght =
        widget.sondeoItem.preguntas?.length ?? 0; //*Returns length from 1
    final double progressValue = 1 / lenght;
    final finishedSections = ref.watch(finishedSondeos);
    final theme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: c.surface,
        title: Text('${widget.sondeoItem.sondeo}', style: t.medium),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).hintColor,
        toolbarHeight: size.height * 0.07,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: c.surface,
          statusBarIconBrightness:
              theme == ThemeMode.light ? Brightness.dark : Brightness.light,
        ),
      ),
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
                        print('CurrentPage: $value');
                        indexGlobal = value;
                        setState(() {});
                      },
                      itemBuilder: (context, index) {
                        print('index ${index + 1}');
                        print('length ${textControllers.length}');
                        // indexGlobal = index;

                        if (widget.sondeoItem.preguntas?[index].tipo ==
                            'asistencia') {
                          return MapView(store: widget.store);
                        } else {
                          return QuestionBuilder(
                            textController: index + 1 <= textControllers.length
                                ? textControllers[inputIndex]
                                : null,
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
                            'Pregunta ${indexGlobal + 1} de ${lenght.ceil()} \n')),
                  )
                : const SizedBox(),

            //*BUTTONS
            if (lenght == 1 || lenght == 0)
              SizedBox(
                height: size.height * 0.09,
                child: Center(
                  child: ButonDimentions(
                    height: size.height * 0.06,
                    width: size.width * 0.5,
                    background:
                        Colors.blue[700] ?? c.secondary.withOpacity(0.8),
                    title: 'Finalizar',
                    style: t.mediumLight,
                    onTap: () => finalize(finishedSections),
                  ),
                ),
              )
            else
              SizedBox(
                height: size.height * 0.09,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                        onPressed: indexGlobal != 0
                            ? () => previousPage(progressValue)
                            : null,
                        style: buttonStyle,
                        child: Text('Prev', style: t.mediumBold)),

                    //
                    if (indexGlobal + 1 != lenght)
                      OutlinedButton(
                          onPressed: () => nextPage(
                              lenght: lenght, progressValue: progressValue),
                          style: buttonStyle,
                          child: Text('Next', style: t.mediumBold))
                    else
                      ButonDimentions(
                        height: size.height * 0.06,
                        width: size.width * 0.35,
                        background:
                            Colors.blue[700] ?? c.secondary.withOpacity(0.8),
                        title: 'Finalizar',
                        style: t.mediumLight,
                        onTap: () => finalize(finishedSections),
                      ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  void getControllersLenght(RespM sondeo) {
    sondeo.preguntas?.forEach((pregunta) {
      if (pregunta.tipo == 'abierta' ||
          pregunta.tipo == 'numerico' ||
          pregunta.tipo == 'email' ||
          pregunta.tipo == 'decimal') {
        setState(() => lenght++);
      }
    });

    textControllers = List.generate(lenght, (index) => TextEditingController());
    setState(() {});
  }

  Future<void> nextPage({
    required int lenght,
    required double progressValue,
  }) async {
    final questionType = widget.sondeoItem.preguntas?[indexGlobal].tipo;
    FocusManager.instance.primaryFocus?.unfocus();
    // print('Tipo: ${widget.sondeoItem.preguntas?[indexGlobal].tipo}');
    // print('indexGlobal n: $indexGlobal');

    print('--------------------------------------------------------------\n');
    print('Input index: $inputIndex');

    //! Validate

    setState(() {});
    //? If TextField
    if (inputs.contains(questionType)) {
      //? Validate TextFields
      print('Is an Input');
      validateInputs(progressValue);
      // return;

      //? If Other components
    } else {
      // * Extract data from others components
      print('Is other component');
      await goNextQuestion(progressValue);
    }
    //
    print('--------------------------------------------------------------\n');
  }

  Future validateInputs(double progressValue) async {
    print('Inputs detected: ${textControllers.length}');
    // final currentPage = pageController.page?.toInt() ?? 0;
    // await goNextQuestion(progressValue);

    //*Validate
    if (textControllers[inputIndex].text.isEmpty) {
      print('Input $inputIndex is empty');
      if (inputIndex <= textControllers.length) {
        print('Returning');
        return;
      }
    } else {
      print('Input have value: ${textControllers[inputIndex].text} ');
      if (!responses.contains(textControllers[inputIndex].text)) {
        setState(() {
          responses.add(textControllers[inputIndex].text);
        });
      }

      setState(() {});
      print('go next');
      await goNextQuestion(progressValue);
      setState(() => inputIndex++);
      print('InputIndex: $inputIndex');
      printResponses();
      setState(() {});
    }
  }

  bool isLastPage(double currentPage) {
    return currentPage.abs() == widget.sondeoItem.preguntas!.length - 1;
  }

  Future<void> goNextQuestion(double progressValue) async {
    final progressBarStillLoading = progressBar != 1;
    // final page = pageController.page ?? 0;

    if (progressBarStillLoading) {
      // setState(() => indexGlobal++);
      print('INDEX GLOBAL: $indexGlobal');
      setState(() => progressBar += progressValue);

      await pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
      setState(() {});
    }
  }

  Future<void> previousPage(double progressValue) async {
    if (progressBar != 0) {
      // final page = pageController.page ?? 0;
      // if (page.abs() > 0) {
      // setState(() => indexGlobal--);
      print('INDEX GLOBAL: $indexGlobal');
      print('Tipo: ${widget.sondeoItem.preguntas?[indexGlobal].tipo}');

      setState(() => progressBar -= progressValue);

      await pageController.previousPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
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

  void disposeControllers() {
    for (var element in textControllers) {
      element.dispose();
    }
  }

  @override
  bool get wantKeepAlive => true;

  //
}

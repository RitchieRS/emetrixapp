import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';

import 'components/components.dart';
import 'controller.dart';

class SondeosBuilder extends ConsumerStatefulWidget {
  const SondeosBuilder({
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

class _SondeosBuilderState extends ConsumerState<SondeosBuilder> {
  final PageController controller = PageController();
  double progress = 0; // 1
  int indexPageView = 0;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int lenght =
        widget.sondeoItem.preguntas?.length ?? 0; //Returns length from 1
    final double progressValue = 1 / lenght;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: c.surface,
        title: Text('${widget.sondeoItem.sondeo}', style: t.medium),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).hintColor,
        toolbarHeight: size.height * 0.07,
      ),
      body: Column(
        children: [
          Container(
            color: c.surface,
            child: Padding(
                padding:
                    const EdgeInsets.only(left: 14.0, right: 14, bottom: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    tween: Tween<double>(
                      begin: 0,
                      end: progress,
                    ),
                    builder: (context, value, _) => LinearProgressIndicator(
                        value: value,
                        minHeight: size.height * 0.008,
                        backgroundColor: c.disabled.withOpacity(0.25)),
                  ),
                )),
          ),
          //CONTENT
          if (widget.sondeoItem.preguntas != null)
            Expanded(
              child: Container(
                color: c.surface,
                child: PageView.builder(
                    controller: controller,
                    allowImplicitScrolling: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.sondeoItem.preguntas?.length,
                    onPageChanged: (value) {
                      setState(() {
                        indexPageView = value;
                      });
                    },
                    itemBuilder: (context, index) => QuestionBuilder(
                          store: widget.store,
                          pregunta: widget.sondeoItem.preguntas?[index] ??
                              Preguntas(),
                        )),
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
                          'Pregunta ${indexPageView + 1} de ${lenght.ceil()} \n')),
                )
              : const SizedBox(),

          //BUTTONS
          if (lenght == 1 || lenght == 0)
            SizedBox(
              height: size.height * 0.09,
              child: Center(
                child: ButonDimentions(
                  height: size.height * 0.06,
                  width: size.width * 0.5,
                  background: Colors.blue[700] ?? c.secondary.withOpacity(0.8),
                  title: 'Finalizar',
                  style: t.mediumLight,
                  onTap: () => goNextSection(),
                ),
              ),
            )
          else
            SizedBox(
              height: size.height * 0.09,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (indexPageView != 0)
                    ButonDimentions(
                        height: size.height * 0.06,
                        width: size.width * 0.35,
                        background: c.primary,
                        title: 'Prev',
                        style: t.mediumLight,
                        onTap: () => previousPage(progressValue))
                  else
                    OutlinedButton(
                        onPressed: null,
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            minimumSize:
                                Size(size.width * 0.35, size.height * 0.06)),
                        child: Text('Prev', style: t.mediumBold)),

                  //
                  if (indexPageView + 1 != lenght)
                    ButonDimentions(
                        height: size.height * 0.06,
                        width: size.width * 0.35,
                        background: c.primary,
                        title: 'Next',
                        style: t.mediumLight,
                        onTap: () => nextPage(lenght, progressValue))
                  else
                    ButonDimentions(
                      height: size.height * 0.06,
                      width: size.width * 0.35,
                      background:
                          Colors.blue[700] ?? c.secondary.withOpacity(0.8),
                      title: 'Finalizar',
                      style: t.mediumLight,
                      onTap: () => goNextSection(),
                    ),
                  // OutlinedButton(
                  //     onPressed: null,
                  //     style: OutlinedButton.styleFrom(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10)),
                  //         minimumSize:
                  //             Size(size.width * 0.35, size.height * 0.06)),
                  //     child: Text('Next', style: t.mediumBold)),
                ],
              ),
            )
        ],
      ),
    );
  }

  void nextPage(int lenght, double progressValue) {
    if (progress != lenght) {
      controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      progress += progressValue;
      setState(() {});
    }
  }

  void previousPage(double progressValue) {
    if (progress != 0) {
      controller.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      progress -= progressValue;
      setState(() {});
    }
  }

  void goNextSection() {
    ref
        .read(currentOptionProvider.notifier)
        .update((state) => state = widget.index + 1);

    setState(() {
      progress = 1;
    });

    Future.delayed(const Duration(milliseconds: 500))
        .whenComplete(() => Navigator.pop(context));
  }

  Future validate() async {
    //Validate
  }

  //
}

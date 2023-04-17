import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';

import 'components/components.dart';

class SondeosBuilder extends ConsumerStatefulWidget {
  const SondeosBuilder({super.key, required this.sondeoItem});
  final RespM sondeoItem;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SondeosBuilderState();
}

class _SondeosBuilderState extends ConsumerState<SondeosBuilder> {
  final PageController controller = PageController();
  double progress = 0; // 1
  int index = 0;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double lenght = widget.sondeoItem.preguntas?.length.toDouble() ?? 0;
    final progressValue = 1 / lenght;

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
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    tween: Tween<double>(
                      begin: 0,
                      end: progress,
                    ),
                    builder: (context, value, _) => LinearProgressIndicator(
                      value: value,
                      minHeight: size.height * 0.008,
                    ),
                  ),
                )),
          ),
          //CONTENT
          if (widget.sondeoItem.preguntas != null)
            Expanded(
              child: Container(
                // color: c.primary.withOpacity(0.2),
                color: c.surface,
                child: PageView.builder(
                  controller: controller,
                  allowImplicitScrolling: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.sondeoItem.preguntas?.length,
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  itemBuilder: (context, index) => ListView(
                    children: [
                      Text(
                        '${widget.sondeoItem.preguntas?[index].pregunta} ',
                        textAlign: TextAlign.center,
                        style: t.mediumBold,
                      ),
                      Center(
                        child: QuestionBuilder(
                          pregunta: widget.sondeoItem.preguntas?[index] ??
                              Preguntas(),
                        ),
                      ),
                      // Text('Pregunta ${index + 1} de ${lenght.ceil()} \n'),
                    ],
                  ),
                ),
              ),
            )
          else
            Text('${widget.sondeoItem.linkWeb}'),

          Padding(
            padding: EdgeInsets.only(top: size.height * 0.01),
            child: Container(
                height: size.height * 0.03,
                color: c.surface,
                child: Text('Pregunta ${index + 1} de ${lenght.ceil()} \n')),
          ),

          //BUTTONS
          if (lenght == 1)
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
                    onTap: () {}),
              ),
            )
          else
            SizedBox(
              height: size.height * 0.09,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (index != 0)
                    ButonDimentions(
                        height: size.height * 0.06,
                        width: size.width * 0.35,
                        background: c.primary,
                        title: 'Prev',
                        style: t.mediumLight,
                        onTap: () => previousPage(lenght, progressValue))
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
                  if (index != lenght - 1)
                    ButonDimentions(
                        height: size.height * 0.06,
                        width: size.width * 0.35,
                        background: c.primary,
                        title: 'Next',
                        style: t.mediumLight,
                        onTap: () => nextPage(lenght, progressValue))
                  else if (index == lenght - 1)
                    ButonDimentions(
                        height: size.height * 0.06,
                        width: size.width * 0.35,
                        background:
                            Colors.blue[700] ?? c.secondary.withOpacity(0.8),
                        title: 'Finalizar',
                        style: t.mediumLight,
                        onTap: () {})
                  else
                    OutlinedButton(
                        onPressed: null,
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            minimumSize:
                                Size(size.width * 0.35, size.height * 0.06)),
                        child: Text('Next', style: t.mediumBold)),
                ],
              ),
            )
        ],
      ),
    );
  }

  nextPage(double lenght, double progressValue) {
    if (progress != lenght) {
      controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      progress += progressValue;
      setState(() {});
    }
  }

  previousPage(double lenght, double progressValue) {
    if (progress != 0) {
      controller.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      progress -= progressValue;
      setState(() {});
    }
  }
}

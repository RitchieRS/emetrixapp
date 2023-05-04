import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class Selection extends ConsumerStatefulWidget {
  const Selection({
    super.key,
    this.yesNo,
    this.oneSelection,
    this.yn = const ['Si', 'No'],
    required this.question,
    required this.pregunta,
  });
  final bool? yesNo;
  final bool? oneSelection;
  final Preguntas question;
  final List<String> yn;
  final Preguntas pregunta;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectionState();
}

class _SelectionState extends ConsumerState<Selection>
    with AutomaticKeepAliveClientMixin {
  late String typeService = widget.yn[0];
  late String multi = widget.question.opciones?[0].opcion ?? '';
  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Text(widget.pregunta.pregunta ?? 'NoData', style: t.subtitle),
        ),
        SizedBox(height: size.height * 0.01),
        Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.01),
          child: Center(
            child: widget.yesNo == true
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.yn.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                        title: Text(widget.yn[index]),
                        activeColor: c.primary,
                        value: index,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedOption = value;
                            });
                          }
                        },
                      );
                    },
                  )
                // Container(
                //     width: size.width * 0.95,
                //     decoration: BoxDecoration(
                //         border: Border.all(color: c.disabled),
                //         borderRadius: BorderRadius.circular(10)),
                //     child: Center(
                //       child: DropdownButton(
                //         underline: Container(),
                //         items: widget.yn.map((item) {
                //           return DropdownMenuItem(
                //             value: item,
                //             child: Text(item),
                //           );
                //         }).toList(),
                //         value: typeService,
                //         icon: const Icon(Icons.keyboard_arrow_down),
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             typeService = newValue!;
                //           });
                //           setState(() {});
                //         },
                //       ),
                //     ),
                //   )
                : widget.oneSelection != true &&
                        widget.question.opciones != null
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.question.opciones!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RadioListTile(
                            title: Text(
                                widget.question.opciones![index].opcion ??
                                    'option'),
                            value: index,
                            activeColor: c.primary,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selectedOption = value;
                                });
                              }
                            },
                          );
                        },
                      )

                    // Container(
                    //     width: size.width * 0.95,
                    //     decoration: BoxDecoration(
                    //         border: Border.all(color: c.disabled),
                    //         borderRadius: BorderRadius.circular(10)),
                    //     child: Center(
                    //       child: DropdownButton(
                    //         underline: Container(),
                    //         items: widget.question.opciones!.map((item) {
                    //           return DropdownMenuItem(
                    //             value: item.opcion ?? '',
                    //             child: Text(item.opcion ?? ''),
                    //           );
                    //         }).toList(),
                    //         value: multi,
                    //         icon: const Icon(Icons.keyboard_arrow_down),
                    //         onChanged: (String? newValue) {
                    //           setState(() {
                    //             multi = newValue!;
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   )
                    : Container(height: 50, color: c.error),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class Selection extends ConsumerStatefulWidget {
  Selection({super.key, this.yesNo, this.oneSelection, required this.question});
  final bool? yesNo;
  final bool? oneSelection;
  final Preguntas question;
  final List<String> yn = ['Si', 'No'];

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectionState();
}

class _SelectionState extends ConsumerState<Selection> {
  late String typeService = widget.yn[0];
  late String multi = widget.question.opciones?[0].opcion ?? '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.01),
      child: Center(
        child: widget.yesNo == true
            ? Container(
                width: size.width * 0.95,
                decoration: BoxDecoration(
                    border: Border.all(color: c.disabled),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: DropdownButton(
                    underline: Container(),
                    items: widget.yn.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    value: typeService,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        typeService = newValue!;
                        //print(typeService);
                      });
                      setState(() {});
                    },
                  ),
                ),
              )
            :
            // Container(height: 50, color: c.error)
            widget.oneSelection != true && widget.question.opciones != null
                ? Container(
                    width: size.width * 0.95,
                    decoration: BoxDecoration(
                        border: Border.all(color: c.disabled),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: DropdownButton(
                        underline: Container(),
                        items: widget.question.opciones!.map((item) {
                          return DropdownMenuItem(
                            value: item.opcion ?? '',
                            child: Text(item.opcion ?? ''),
                          );
                        }).toList(),
                        value: multi,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onChanged: (String? newValue) {
                          setState(() {
                            multi = newValue!;
                          });
                        },
                      ),
                    ),
                  )
                : Container(height: 50, color: c.error),
      ),
    );
  }
}

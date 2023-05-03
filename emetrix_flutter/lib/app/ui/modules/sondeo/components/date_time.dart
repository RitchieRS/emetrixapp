import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class PickerDT extends ConsumerStatefulWidget {
  const PickerDT({
    super.key,
    this.onlyDate,
    this.onlyTime,
    required this.pregunta,
  });
  final bool? onlyDate;
  final bool? onlyTime;
  final String pregunta;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PickerDTState();
}

class _PickerDTState extends ConsumerState<PickerDT> {
  DateTime selectedDate = DateTime(2001);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Text(widget.pregunta),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ButonDimentions(
            height: size.height * 0.08,
            width: size.width * 0.9,
            background: Colors.white,
            title:
                'Establece ${widget.onlyDate == true ? 'Fecha' : widget.onlyTime == true ? 'Hora' : 'Fecha y Hora'}',
            style: t.mediumBlue2,
            onTap: () => handleTime(),
            showShadow: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              widget.onlyDate == true
                  ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                  : widget.onlyTime == true
                      ? '${selectedDate.hour}:${selectedDate.minute}'
                      : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year} \n ${selectedDate.hour}:${selectedDate.minute}',
              style: t.subtitle),
        )
      ],
    );
  }

  void handleTime() async {
    widget.onlyDate == true
        ? setDate()
        : widget.onlyTime == true
            ? setTime()
            : DatePicker.showDateTimePicker(context,
                showTitleActions: true,
                minTime: DateTime(2018, 3, 5),
                maxTime: DateTime(2019, 6, 7), onConfirm: (date) {
                setState(() {
                  selectedDate = date;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.es);
  }

  Future setDate() async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30))) ??
        DateTime(2001);
    setState(() {});
  }

  Future setTime() async {
    final timeOrDay = await showRoundedTimePicker(
        context: context, initialTime: TimeOfDay.now());
    final newTime =
        DateTime(2023, 1, 1, timeOrDay?.hour ?? 0, timeOrDay?.minute ?? 0);

    setState(() {
      selectedDate = newTime;
    });
  }
}

import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class PickerDT extends ConsumerStatefulWidget {
  const PickerDT({super.key, this.onlyDate, this.onlyTime});
  final bool? onlyDate;
  final bool? onlyTime;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PickerDTState();
}

class _PickerDTState extends ConsumerState<PickerDT> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Buton(
        background: Colors.white,
        title:
            'Establece ${widget.onlyDate == true ? 'Fecha' : widget.onlyTime == true ? 'Hora' : 'Fecha y Hora'}',
        style: t.mediumBlue2,
        onTap: () {
          widget.onlyDate == true
              ? showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)))
              : widget.onlyTime == true
                  ? showRoundedTimePicker(
                      context: context, initialTime: TimeOfDay.now())
                  : DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2019, 6, 7),
                      //   onChanged: (date) {
                      //   print('change $date');
                      // }, onConfirm: (date) {
                      //   print('confirm $date');
                      // },
                      currentTime: DateTime.now(),
                      locale: LocaleType.es);
        },
        showShadow: true,
      ),
    );
  }
}

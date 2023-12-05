// ignore_for_file: use_build_context_synchronously
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class PickerDT extends ConsumerStatefulWidget {
  const PickerDT({
    super.key,
    this.onlyDate,
    this.onlyTime,
    required this.pregunta,
    required this.getDateTime,
    this.mandatory = false,
    required this.preguntaId,
  });
  final bool? onlyDate;
  final bool? onlyTime;
  final String pregunta;
  final Preguntas preguntaId;
  final Function(DateTime?) getDateTime;
  final bool mandatory;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PickerDTState();
}

class _PickerDTState extends ConsumerState<PickerDT>
    with AutomaticKeepAliveClientMixin {
  DateTime? selectedDate;
  TimeOfDay selectedTime = TimeOfDay.now();
  var stringManager;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    stringManager = ref
        .watch(stringManagerProvider(int.parse(widget.preguntaId.id ?? '0')));

    final size = MediaQuery.of(context).size;
    final paddingVertical = size.height * 0.012;
    final paddingHorizontal = size.width * 0.04;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: widget.mandatory ? c.errorLight : c.surface,
      child: Padding(
        padding: EdgeInsets.only(bottom: paddingVertical * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: Text(widget.pregunta, style: t.subtitle),
            ),
            SizedBox(height: paddingVertical),
            Center(
              child: Text(stringManager.currentString,
                  style: selectedDate == null ? t.text : t.text,
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: paddingVertical),
            Center(
              child: Buton(
                outlined: true,
                background: c.primary500,
                title: widget.onlyDate == true
                    ? 'Fecha'
                    : widget.onlyTime == true
                        ? 'Hora'
                        : 'Fecha/Hora',
                style: t.mediumBlue2,
                onTap: () => _handleTime(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String showDateOrTime() {
    if (widget.onlyDate == true) {
      if (selectedDate != null) {
        stringManager.updateString(
            '${selectedDate?.day}/${_months()}/${selectedDate?.year}');
        return '${selectedDate?.day}/${_months()}/${selectedDate?.year}';
      } else {
        return '';
        // return 'dia/mes/año';
      }
    } else if (widget.onlyTime == true) {
      if (selectedDate != null) {
        stringManager.updateString(selectedTime.format(context));
        return selectedTime.format(context);
      } else {
        return '';
        // return 'hora:min';
      }
    } else {
      if (selectedDate != null) {
        stringManager.updateString(
            '${selectedDate?.day}/${_months()}/${selectedDate?.year} \n ${selectedTime.format(context)}');
        return '${selectedDate?.day}/${_months()}/${selectedDate?.year} \n ${selectedTime.format(context)}';
      } else {
        return '';
        // return 'dia/mes/año \n hora:min';
      }
    }
  }

  String _months() {
    final Map<int, String> months = {
      1: 'Enero',
      2: 'Febrero',
      3: 'Marzo',
      4: 'Abril',
      5: 'Mayo',
      6: 'Junio',
      7: 'Julio',
      8: 'Agosto',
      9: 'Septiembre',
      10: 'Octubre',
      11: 'Noviembre',
      12: 'Diciembre',
    };
    return months[selectedDate?.month] ?? 'Mes';
  }

  void _handleTime() async {
    if (widget.onlyDate == true) {
      await _setDate();
    } else if (widget.onlyTime == true) {
      await _setTime(context);
    } else {
      await _setDateNTime(context);
    }
    showDateOrTime();
  }

  Future _setDate() async {
    selectedDate = await showDatePicker(
            context: context,
            locale: const Locale('es', 'ES'),
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30))) ??
        DateTime.now();
    widget.getDateTime(selectedDate);
    setState(() {});
  }

  Future _setTime(BuildContext context) async {
    final hour = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: TimeOfDay.fromDateTime(selectedDate ?? DateTime.now()),
    );

    if (hour != null) {
      setState(() {
        selectedTime = hour;
        selectedDate = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, hour.hour, hour.minute);
        widget.getDateTime(selectedDate);
      });
    }
  }

  Future<void> _setDateNTime(BuildContext context) async {
    final date = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            locale: const Locale('es', 'ES'),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30))) ??
        DateTime.now();

    if (date != selectedDate) {
      TimeOfDay? hour = await showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.dial,
        initialTime: TimeOfDay.fromDateTime(selectedDate ?? DateTime.now()),
      );

      if (hour != null) {
        setState(() {
          selectedTime = hour;
          selectedDate = DateTime(
            date.year,
            date.month,
            date.day,
            hour.hour,
            hour.minute,
          );

          widget.getDateTime(selectedDate);
        });
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}

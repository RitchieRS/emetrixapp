// ignore_for_file: use_build_context_synchronously
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
  });
  final bool? onlyDate;
  final bool? onlyTime;
  final String pregunta;
  final Function(DateTime?) getDateTime;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PickerDTState();
}

class _PickerDTState extends ConsumerState<PickerDT>
    with AutomaticKeepAliveClientMixin {
  // DateTime selectedDate = DateTime.now();
  DateTime? selectedDate;

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
          child: Text(widget.pregunta, style: t.subtitle),
        ),
        SizedBox(height: size.height * 0.02),
        Center(
          child: Text(
              widget.onlyDate == true && selectedDate != null
                  ? '${selectedDate?.day}/${_months()}/${selectedDate?.year}'
                  : widget.onlyDate == true && selectedDate == null
                      ? 'dia/mes/año'
                      : widget.onlyTime == true && selectedDate != null
                          ? _formatTime(selectedDate?.hour ?? 0,
                              selectedDate?.minute ?? 0)
                          : widget.onlyTime == true && selectedDate == null
                              ? 'hora:min'
                              : selectedDate != null
                                  ? '${selectedDate?.day}/${_months()}/${selectedDate?.year} \n ${_formatTime(selectedDate?.hour ?? 0, selectedDate?.minute ?? 0)}'
                                  : 'dia/mes/año \n hora:min',
              style: selectedDate == null ? t.mediumDisabled : t.mediumBlue,
              textAlign: TextAlign.center),
        ),
        SizedBox(height: size.height * 0.02),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ButonDimentions(
              height: size.height * 0.065,
              width: size.width * 0.85,
              background: c.primary,
              title:
                  'Establece ${widget.onlyDate == true ? 'Fecha' : widget.onlyTime == true ? 'Hora' : 'Fecha y Hora'}',
              style: t.mediumLight,
              onTap: () => _handleTime(),
              shadow: 5,
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(int hours2, int minutes2) {
    String hours = (hours2 < 10) ? '0$hours2' : hours2.toString();
    String minutes = (minutes2 < 10) ? '0$minutes2' : minutes2.toString();
    return '$hours:$minutes';
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
    widget.onlyDate == true
        ? _setDate()
        : widget.onlyTime == true
            ? _setTime(context)
            : _setDateNTime(context);
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
      initialTime: TimeOfDay.fromDateTime(selectedDate ?? DateTime.now()),
    );

    if (hour != null) {
      setState(() {
        selectedDate = DateTime(2023, 1, 1, hour.hour, hour.minute);
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
      final hour = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate ?? DateTime.now()),
      );

      if (hour != null) {
        setState(() {
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

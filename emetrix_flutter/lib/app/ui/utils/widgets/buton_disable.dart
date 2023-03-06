import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButonDisabled extends ConsumerStatefulWidget {
  const ButonDisabled(
      {required this.background,
      required this.title,
      required this.style,
      this.showShadow,
      super.key});

  final Color background;
  final String title;
  final TextStyle style;
  final bool? showShadow;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ButonDisabledState();
}

class _ButonDisabledState extends ConsumerState<ButonDisabled> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: widget.showShadow == true
            ? [
                BoxShadow(
                    color: c.disabled.withOpacity(0.4),
                    blurRadius: 20.0,
                    offset: const Offset(1, 1))
              ]
            : [],
        color: widget.background,
      ),
      height: size.height * 0.065,
      width: size.width * 0.85,
      child: Center(
        child: Text(
          widget.title,
          style: widget.style,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class Buton extends ConsumerStatefulWidget {
  const Buton(
      {required this.background,
      required this.title,
      required this.style,
      required this.onTap,
      this.showShadow,
      super.key});

  final VoidCallback onTap;
  final Color background;
  final String title;
  final TextStyle style;
  final bool? showShadow;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ButonState();
}

class _ButonState extends ConsumerState<Buton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: widget.onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: widget.showShadow == true
              ? [
                  BoxShadow(
                      color: c.disabled.withOpacity(0.4),
                      blurRadius: 10.0,
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
      ),
    );
  }
}

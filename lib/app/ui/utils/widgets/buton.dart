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
      this.outlined = false,
      super.key});

  final VoidCallback onTap;
  final Color background;
  final String title;
  final TextStyle style;
  final bool? showShadow;
  final bool outlined;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ButonState();
}

class _ButonState extends ConsumerState<Buton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: c.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: widget.onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: widget.outlined
                ? Border.all(color: widget.background, width: 1.5)
                : null,
            boxShadow: widget.showShadow == true
                ? [
                    BoxShadow(
                        color: c.disabled.withOpacity(0.4),
                        blurRadius: 10.0,
                        offset: const Offset(1, 1))
                  ]
                : [],
            color: widget.outlined
                ? Theme.of(context).scaffoldBackgroundColor
                : widget.background,
          ),
          height: size.height * 0.052,
          width: size.width * 0.9,
          child: Center(
            child: Text(
              widget.title,
              style: widget.style,
            ),
          ),
        ),
      ),
    );
  }
}

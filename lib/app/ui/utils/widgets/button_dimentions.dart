import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButonDimentions extends ConsumerStatefulWidget {
  const ButonDimentions({
    required this.background,
    required this.title,
    required this.style,
    required this.onTap,
    required this.width,
    required this.height,
    this.shadow,
    this.padding,
    super.key,
  });

  final VoidCallback onTap;
  final Color background;
  final String title;
  final TextStyle style;
  final double? shadow;
  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Buton2State();
}

class _Buton2State extends ConsumerState<ButonDimentions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      child: Center(
        child: Material(
          elevation: widget.shadow ?? 0,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: widget.onTap,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.background,
              ),
              height: widget.height,
              width: widget.width,
              child: Center(
                child: Text(widget.title, style: widget.style),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   duration: const Duration(seconds: 3),
        //   elevation: 0,
        //   dismissDirection: DismissDirection.startToEnd,
        //   backgroundColor: c.secondary,
        //   content: Text('Bienvenid@ de nuevo!', style: t.buttonBlue2),
        //   behavior: SnackBarBehavior.floating,
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        //   margin: EdgeInsets.only(
        //     bottom: size.height * 0.04,
        //     right: size.height * 0.025,
        //     left: size.height * 0.025,
        //   ),
        // ));
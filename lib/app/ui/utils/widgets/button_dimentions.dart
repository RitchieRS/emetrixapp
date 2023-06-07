import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class ButonDimentions extends ConsumerStatefulWidget {
  const ButonDimentions(
      {required this.background,
      required this.title,
      required this.style,
      required this.onTap,
      this.showShadow,
      required this.width,
      required this.height,
      super.key});

  final VoidCallback onTap;
  final Color background;
  final String title;
  final TextStyle style;
  final bool? showShadow;
  final double width;
  final double height;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Buton2State();
}

class _Buton2State extends ConsumerState<ButonDimentions> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: widget.onTap,
          child: Ink(
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
            height: widget.height,
            width: widget.width,
            child: Center(
              child: Text(widget.title, style: widget.style),
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
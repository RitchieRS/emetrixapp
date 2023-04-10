import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButonLoading extends ConsumerStatefulWidget {
  const ButonLoading(
      {required this.background,
      required this.onFinish,
      this.showShadow,
      required this.width,
      required this.height,
      super.key});

  final VoidCallback? onFinish;
  final Color background;
  final bool? showShadow;
  final double width;
  final double height;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Buton2State();
}

class _Buton2State extends ConsumerState<ButonLoading> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: widget.onFinish,
        child: Ink(
            height: widget.height,
            width: widget.width,
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
            child: Center(
              heightFactor: 1,
              widthFactor: 1,
              child: SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: c.background,
                ),
              ),
            )),
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
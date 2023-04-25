import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class TxtField extends ConsumerStatefulWidget {
  const TxtField(
      {super.key,
      required this.controller,
      required this.isPassword,
      required this.obscurePassword,
      required this.onPressed
      // required this.onChanged
      });
  final TextEditingController controller;
  final bool isPassword;
  final bool obscurePassword;
  final void Function()? onPressed;
  // final Function(String text) onChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TxtFieldState();
}

class _TxtFieldState extends ConsumerState<TxtField> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return widget.isPassword == false
        ? Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.01, bottom: size.height * 0.01),
            child: TextField(
                controller: widget.controller,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 12, bottom: 0, top: size.height * 0.055 / 3),
                    prefixIcon: const Icon(Icons.alternate_email),
                    constraints: BoxConstraints(
                        maxHeight: size.height * 0.055,
                        maxWidth: size.width * 0.9),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: c.primary),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black54.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Ingresa usuario')),
          )
        : Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.01, bottom: size.height * 0.01),
            child: TextField(
                controller: widget.controller,
                keyboardType: TextInputType.emailAddress,
                obscureText: widget.obscurePassword,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 12, bottom: 0, top: size.height * 0.055 / 3),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: widget.onPressed,
                        icon: Icon(widget.obscurePassword == false
                            ? Icons.remove_red_eye
                            : Icons.visibility_off)),
                    constraints: BoxConstraints(
                        maxHeight: size.height * 0.055,
                        maxWidth: size.width * 0.9),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: c.primary),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black54.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Ingresa contraseña')),
          );
  }

  Widget clearText() {
    setState(() {});
    return IconButton(
        onPressed: () => widget.controller.clear(),
        icon: const Icon(Icons.close));
  }

  Widget empty() {
    setState(() {});
    return Container(width: 0);
  }
}

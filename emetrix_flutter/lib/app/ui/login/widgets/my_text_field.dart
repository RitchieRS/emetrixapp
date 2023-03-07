import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TxtField extends ConsumerStatefulWidget {
  TxtField(
      {super.key,
      required this.controller,
      required this.isPassword,
      required this.obscurePassword});
  final TextEditingController controller;
  final bool isPassword;
  bool obscurePassword;

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
                autocorrect: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 12, bottom: 0, top: size.height * 0.055 / 2),
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
                    hintText: 'Ingresa tu Nombre de usuario')),
          )
        : Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.01, bottom: size.height * 0.01),
            child: TextField(
                controller: widget.controller,
                keyboardType: TextInputType.emailAddress,
                obscureText: widget.obscurePassword,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 12, bottom: 0, top: size.height * 0.055 / 2),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () => setState(() {
                              widget.obscurePassword = !widget.obscurePassword;
                            }),
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
                    hintText: 'Ingresa tu contraseña')),
          );
  }
}

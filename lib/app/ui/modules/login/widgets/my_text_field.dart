import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class TxtField extends ConsumerStatefulWidget {
  const TxtField({
    super.key,
    required this.controller,
    required this.isPassword,
    required this.formKey,
    this.hinText = 'Ingresa texto',
    // required this.onChanged
  });
  final TextEditingController controller;
  final bool isPassword;
  final GlobalKey<FormState> formKey;
  final String hinText;
  // final Function(String text) onChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TxtFieldState();
}

class _TxtFieldState extends ConsumerState<TxtField> {
  bool obscure = true;
  Color iconColor = Colors.black54.withOpacity(0.4);
  final enebledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54.withOpacity(0.2)),
    borderRadius: BorderRadius.circular(10),
  );
  final focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: c.primary),
    borderRadius: BorderRadius.circular(10),
  );
  final errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: c.error),
    borderRadius: BorderRadius.circular(10),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height * 0.055;
    final width = size.width * 0.9;
    final contentPadding = EdgeInsets.only(
      left: 12,
      bottom: 0,
      top: height / 2,
    );
    final outsidePadding = EdgeInsets.only(
      top: size.height * 0.01,
      bottom: size.height * 0.01,
    );

    return Center(
      child: Padding(
        padding: outsidePadding,
        child: Form(
          key: widget.formKey,
          child: TextFormField(
              controller: widget.controller,
              validator: (value) => validateEmpty(value),
              onChanged: (value) => validateAndSave(),
              keyboardType: TextInputType.emailAddress,
              obscureText: widget.isPassword ? obscure : false,
              textCapitalization: TextCapitalization.none,
              decoration: InputDecoration(
                contentPadding: contentPadding,
                prefixIcon: Icon(
                    widget.isPassword ? Icons.lock : Icons.alternate_email,
                    color: iconColor),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: () => handleObscure(),
                        icon: Icon(
                            obscure
                                ? Icons.visibility_off
                                : Icons.remove_red_eye,
                            color: obscure
                                ? Colors.black54.withOpacity(0.4)
                                : c.primary))
                    : null,
                constraints: BoxConstraints(minHeight: height, maxWidth: width),
                focusedBorder: focusedBorder,
                enabledBorder: enebledBorder,
                errorBorder: errorBorder,
                focusedErrorBorder: errorBorder,
                hintText: widget.hinText,
              )),
        ),
      ),
    );
  }

  void validateAndSave() {
    final form = widget.formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        setState(() => iconColor = c.primary);
        return;
      }
      setState(() => iconColor = c.error);
      return;
    }
    setState(() => iconColor = Colors.black54.withOpacity(0.4));
  }

  String? validateEmpty(String? value) {
    if (value == null) {
      return '';
    }
    if (value == '' || value.isEmpty) {
      return 'Completa el campo';
    }

    return null;
  }

  void handleObscure() {
    setState(() => obscure = !obscure);
  }
}

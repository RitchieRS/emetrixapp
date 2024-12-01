import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/material.dart';

class InfoQuestion extends StatelessWidget {
  const InfoQuestion({
    super.key,
    required this.pregunta,
  });
  final String pregunta;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Center(
          child: Container(
            height: size.height * 0.1,
            width: size.width,
            color: c.primary200,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(pregunta),
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
      ],
    );
  }
}

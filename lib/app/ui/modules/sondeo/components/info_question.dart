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

    return Center(
      child: Container(
        height: size.height * 0.1,
        width: size.width,
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(pregunta),
          ),
        ),
      ),
    );
  }
}

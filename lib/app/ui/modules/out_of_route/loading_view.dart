import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';

import 'widgets/shimmer_cards.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const GradientTitle(title: 'Fuera de Ruta'),
      body: ListView.builder(
          padding: EdgeInsets.only(top: size.height * 0.02),
          shrinkWrap: true,
          itemCount: 10,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return const LoadingCard();
          }),
    );
  }
}

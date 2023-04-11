import 'package:emetrix_flutter/app/ui/outOfRoute/widgets/shimmer_cards.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/gradient_title.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          GradientTitle(
            height: size.height,
            width: size.width,
            title1: 'Fuera de',
            title2: 'RUTA',
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(35)),
            child: Container(
              height: size.height * 0.75,
              width: size.width,
              color: ThemeData().scaffoldBackgroundColor,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const LoadingCard();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

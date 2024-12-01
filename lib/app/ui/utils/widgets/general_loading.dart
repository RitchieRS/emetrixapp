import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class GeneralLoading extends StatelessWidget {
  const GeneralLoading({
    super.key,
    this.loadingCards = 3,
  });
  final int loadingCards;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        ListView.builder(
            padding: EdgeInsets.only(top: size.height * 0.02),
            shrinkWrap: true,
            itemCount: loadingCards,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return LoadingCard(index: index);
            }),
      ],
    );
  }
}

class LoadingCard extends StatelessWidget {
  const LoadingCard(
      {super.key, this.height = 0.11, this.width = 0.95, this.index = 0});
  final double height;
  final double width;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.height * 0.01;

    return Padding(
      padding: EdgeInsets.only(bottom: padding, left: padding, right: padding),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Shimmer.fromColors(
            baseColor: c.black.withOpacity(0.2),
            highlightColor: Colors.white.withOpacity(0.8),
            loop: 1000000000000000000,
            period: Duration(milliseconds: duration()),
            child: Container(
              height: size.height * height,
              width: size.width * 0.95,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
      ),
    );
  }

  int duration() {
    if (index % 2 == 0) {
      return 1660;
    }
    return 1500;
  }
}

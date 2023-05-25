import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.01),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).highlightColor,
            highlightColor: Colors.white.withOpacity(0.8),
            loop: 1000000000000000000,
            period: const Duration(milliseconds: 750),
            child: Container(
              height: size.height * 0.125,
              width: size.width * 0.95,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
      ),
    );
  }
}

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
            baseColor: Colors.grey.withOpacity(0.7),
            highlightColor: Colors.white,
            loop: 3,
            child: Container(
              height: size.height * 0.11,
              width: size.width * 0.95,
              color: Colors.grey.withOpacity(0.45),
            ),
          ),
        ),
      ),
    );
  }
}

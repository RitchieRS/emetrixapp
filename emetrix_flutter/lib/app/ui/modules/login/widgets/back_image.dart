import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class BackImage extends StatelessWidget {
  const BackImage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        //   stops: const [0.1, 0.5],
        //   colors: [
        //     c.secondary,
        //     c.primary.withOpacity(0.55),
        //   ],
        // ),
        color: c.background,
      ),
      child: Stack(
        children: [
          const CircleAvatar(),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.1,
                left: size.width * 0.3,
                right: size.width * 0.3),
            child: CircleAvatar(radius: size.width * 0.12),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.04, left: size.width * 0.8, right: 05),
            child: const CircleAvatar(),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.84, left: size.width * 0.1, right: 100),
            child: const CircleAvatar(),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.9, left: size.width * 0.8, right: 0),
            child: const CircleAvatar(),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.6, left: size.width * 0.9, right: 200),
            child: const CircleAvatar(),
          ),
          SizedBox(
            height: size.height,
            width: size.width,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                color: c.surface,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.11,
                left: size.width * 0.35,
                right: size.width * 0.35),
            child: Image.asset(AppAssets.logo),
          ),
        ],
      ),
    );
  }
}

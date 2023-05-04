import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';

class PageCustom extends StatelessWidget {
  const PageCustom(
      {super.key,
      required this.title,
      required this.content,
      required this.image});
  final String title;
  final String content;
  final String image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.05),
          child: FadeIn(
              child: SvgPicture.asset(image,
                  height: size.height * 0.25, width: size.width * 0.9)),
        ),
        FadeIn(child: Text(title, style: t.subtitle)),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.01),
          child: FadeIn(
            child: Container(
              width: size.width * 0.9,
              color: c.surface,
              child:
                  Text(content, style: t.text2, textAlign: TextAlign.justify),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      color: ThemeData().scaffoldBackgroundColor,
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //   begin: Alignment.topRight,
      //   end: Alignment.bottomLeft,
      //   stops: const [0.1, 0.5],
      //   colors: [c.secondary.withOpacity(0.45), c.primary.withOpacity(0.15)],
      // )),
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.035),
        child: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios, color: c.primary)),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('RUTA', style: t.titleBlue),
                Text('Del Dia', style: t.textBlue),
              ],
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class MyTitle extends StatelessWidget implements PreferredSizeWidget {
  const MyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return AppBar(
      // automaticallyImplyLeading: true,
      leading: IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Icon(Icons.menu, color: c.primary)),
      title: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('RUTA', style: t.titleBlue),
          Text('Del Dia', style: t.textBlue),
        ],
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      iconTheme: IconThemeData(color: c.primary),
      centerTitle: true,
      toolbarHeight: Dimentions().getHeight() * 0.12,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimentions().getHeight() * 0.12);
}

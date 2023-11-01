import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
// import 'package:emetrix_flutter/app/core/services/database/database.dart';

class ProductsSkuPage extends ConsumerStatefulWidget {
  const ProductsSkuPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsSkuPageState();
}

class _ProductsSkuPageState extends ConsumerState<ProductsSkuPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Captura SKU',
            style: isDark == ThemeMode.dark ? t.titleWhite : t.titleBlack),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: size.height * 0.1,
        systemOverlayStyle: isDark == ThemeMode.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        actions: [
          IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
                setState(() {});
              },
              icon: isDark == ThemeMode.dark
                  ? const Icon(Icons.dark_mode_outlined)
                  : Icon(Icons.light_mode, color: c.disabled))
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        // padding: const EdgeInsets.only(top: 0),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(children: [
                  ListTile(
                    title: Text('GENERICO VINA', style: t.mediumBold),
                    subtitle: Text('34567865456', style: t.text),
                    onTap: () {},
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    leading: const Icon(Icons.info),
                    minLeadingWidth: 25,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:emetrix_flutter/app/core/modules/productos/productos.dart';
import 'package:emetrix_flutter/app/ui/modules/products_sku/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
// import 'package:emetrix_flutter/app/core/services/database/database.dart';
import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';




class ProductsSkuPage extends ConsumerStatefulWidget {
  const ProductsSkuPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsSkuPageState();
}


class _ProductsSkuPageState extends ConsumerState<ProductsSkuPage> {
  late final List<ProductosIsar> names;
  String _scanBarcode = 'Unknown';
  @override
  void initState(){
    super.initState();
    /*getAllProducts().then((value) => 
    setState(() => names = value!
    ));*/
   
  }

 Future<List<ProductosIsar>?> getAllProducts() async {
    final productosArr = await ref.read(skuCtrlr.notifier).getAllProdcutsCtrl(ref);
    return productosArr;
        
 }

 Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

 final TextEditingController _searchController = TextEditingController();

  final searchText = ValueNotifier<String>('');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarWithSearchSwitch(
        onChanged: (text) {
          searchText.value = text;
        },
        // onSubmitted: (text) {
        //   searchText.value = text;
        // },
        animation: AppBarAnimationSlideLeft.call,
        // animation: (child) => AppBarAnimationSlideLeft(
        //     milliseconds: 400, withFade: false, percents: 0.25, child: child),
        appBarBuilder: (context) {
          return AppBar(
            centerTitle: true,
            title: Text('AppBar'),
            leading: IconButton(
              onPressed: () async {
               scanBarcodeNormal();
              },
              icon: Icon(Icons.home),
            ),
            actions: const [
              AppBarSearchButton(),
              // or
              // IconButton(onPressed: AppBarWithSearchSwitch.of(context)?startSearch, icon: Icon(Icons.search)),
            ],
          );
        },
      ),
      body:Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
          if(snapshot.data!=null)
          {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              var productosObj =  snapshot.data?[index];
              return ListView(
                  shrinkWrap: true,
                  // padding: const EdgeInsets.only(top: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(children: [
                                  ListTile(
                                                      title: Text(productosObj!.nombre.toString(), style: t.mediumBold),
                                                      subtitle: Text(productosObj.sku.toString(), style: t.text),
                                                      onTap: () {},
                                                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                                                      leading: const Icon(Icons.info),
                                                      minLeadingWidth: 25,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(14)),
                                                    )
                                    ,
                                  ]),
                        ),
                      ),
                    ),
                  ],
                );
            },
          );
    
          }
         return const CircularProgressIndicator();
         }, future: getAllProducts()    
        ,)
      )
    );
  }




    //List productos_iterable = getAllProducts();
   /* return Scaffold(
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
                                  )
                  ,
                ]),
              ),
            ),
          ),
        ],
      ),
    );*/
}


import 'dart:async';
import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/modules/productos/productos.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/products_sku/controller.dart';
import 'package:emetrix_flutter/app/ui/modules/products_sku/productos_search_delegate.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/sondeo_individual.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
// import 'package:emetrix_flutter/app/core/services/database/database.dart';

class ProductsSkuPage extends ConsumerStatefulWidget {
  const ProductsSkuPage({
    super.key,
    required this.sondeoItem,
    required this.index,
    required this.stepsLenght,
    required this.store,
    required this.storeUuid,
    required this.stepUuid,
  });
  final RespM sondeoItem;
  final Store2 store;
  final int index;
  final int stepsLenght;
  final String storeUuid;
  final String stepUuid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsSkuPageState();
}

class _ProductsSkuPageState extends ConsumerState<ProductsSkuPage> {
  late final List<ProductosIsar> names;
  String scanBarcode = 'Unknown';
  final searchController = TextEditingController();
  final searchText = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    /*getAllProducts().then((value) => 
    setState(() => names = value!
    ));*/
  }

  Future<List<ProductosIsar>?> getAllProducts() async {
    final productosArr =
        await ref.read(skuCtrlr.notifier).getAllProdcutsCtrl(ref);
    return productosArr;
  }

  @override
  Widget build(BuildContext context) {
    late Future<List<ProductosIsar>?> listProductos = getAllProducts();
    
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: ListTile(
                onTap: () {
                  showSearch(
                      context: context,
                      delegate: ProductosSearchDelegate(
                        listProductos,
                        widget.index,
                        widget.stepsLenght,
                        widget.store,
                        widget.storeUuid,
                        widget.sondeoItem.uuid ?? '',
                        widget.sondeoItem,
                      ));
                },
                title: const Text('Buscar',
                    style: TextStyle(color: Colors.grey)))),
        body: Center(
            child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  var productosObj = snapshot.data?[index];
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
                              color: Theme.of(context)
                                  .highlightColor
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(children: [
                              ListTile(
                                title: Text(
                                    productosObj?.productos?.nombre
                                            .toString() ??
                                        '',
                                    style: t.mediumBold),
                                subtitle: Text(
                                    productosObj?.productos?.sku.toString() ??
                                        '',
                                    style: t.text),
                                onTap: () async {
                                  removeProviderIndex(widget.sondeoItem.preguntas);
                                  await Navigator.push(context,
                                      CupertinoPageRoute(builder: (context) {
                                    return // sondeosList2[index].preguntas?.first.tipo == 'asistencia'
                                        SingleSondeoPage(
                                      store: widget.store,
                                      sondeoItem: widget.sondeoItem,
                                      index: int.parse( productosObj?.productos?.sku ?? '0'),
                                      stepsLenght: widget.stepsLenght,
                                      storeUuid: widget.storeUuid,
                                      stepUuid: widget.sondeoItem.uuid ?? '',
                                    );
                                  }));
                                },
                                trailing: const Icon(Icons.arrow_forward_ios,
                                    size: 18),
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
                  );
                },
              );
            }
            return const CircularProgressIndicator();
          },
          future: getAllProducts(),
        )));
  }

   @override
  void dispose() {
    //_stopwatch.stop();
    super.dispose();
  }

   void removeProviderIndex(List<Preguntas>? preguntas){
  
   
    for(var pregunta in preguntas!){
      
       if(pregunta.tipo == 'abierta' || pregunta.tipo == 'numerico' ||pregunta.tipo == 'decimal' || pregunta.tipo == 'email' ) {
         var provider =  ref.watch(textEditingControllerProvider( int.parse(pregunta.id ?? '0')));
         if(provider.value.text != '' ){
             provider.value = TextEditingValue.empty;
         }
       }
       logger.i("Tipopregunta: ${pregunta.tipo}");
       if(pregunta.tipo == 'foto' || pregunta.tipo ==  'fotoGuardarCopia' || pregunta.tipo ==  'imagen'){
        var provider  =  ref.watch(imageFileProviderFamily(int.parse(pregunta.id ?? '0')));
       
          if(provider?.file != null ){
            provider?.file = null;
          }
       }

    }

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


import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/modules/productos/productos.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/sondeo_individual.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ProductosSearchDelegate extends SearchDelegate<ProductosIsar>{
  
  
  ProductosSearchDelegate(
             this.productosList,
             this.index,
             this.stepsLenght,
             this.store,
             this.storeUuid,
             this.stepUuid, 
             this.sondeoItem
    );
    late final Future<List<ProductosIsar>?> productosList;
    final RespM sondeoItem;
    final Store2 store;
    final int index;
    final int stepsLenght;
    final String storeUuid;
    final String stepUuid;
    

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton( 
      onPressed:(){
        query='';
       }, icon: const  Icon(Icons.close)
       )];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return Center();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
   return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    // TODO: implement buildSuggestions
    return Center(
            child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.data != null) {

                List<ProductosIsar>? productList = snapshot.data!;
             
            productList  = productList.where((p) =>
             /// logger.d("Filtro Query ${p.productos!.sku}");
              ///logger.d("Filtro Query $query");
                   p.productos?.sku!.contains(query.trim().toLowerCase()) ??  false
                         
                ).toList();
             
            
              logger.d("Filtro ${snapshot.data!.length}");
              logger.d("Filtro ${productList.length}");
              return ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
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
                                    productList![index].productos?.nombre
                                            .toString() ??
                                        '',
                                    style: t.mediumBold),
                                subtitle: Text(
                                    productList![index].productos?.sku.toString() ??
                                        '',
                                    style: t.text),
                                onTap: () async {
                                await Navigator.push(context, CupertinoPageRoute(builder: (context) {
                                      return // sondeosList2[index].preguntas?.first.tipo == 'asistencia'
                                              SingleSondeoPage(
                                                  store: store,
                                                  sondeoItem: sondeoItem,
                                                  index: index,
                                                  stepsLenght: stepsLenght,
                                                  storeUuid: storeUuid,
                                                  stepUuid: sondeoItem.uuid ?? '',
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
          }, future: productosList,
         
        ));
  }

  void _onQRViewCreated(QRViewController controller) {
  
  
  controller.scannedDataStream.listen((Barcode scanData) {
   
      query = scanData.code!;
    
  });
 
}

}
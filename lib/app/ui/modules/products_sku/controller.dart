
import 'package:emetrix_flutter/app/core/modules/productos/productos.dart';
import 'package:emetrix_flutter/app/core/services/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//Controller
final skuCtrlr = StateNotifierProvider<AuthSku, dynamic>((_) => AuthSku(''));

class AuthSku extends StateNotifier {
  AuthSku(super.state);

  Future <List<ProductosIsar>?> getAllProdcutsCtrl(WidgetRef ref) async {
    final resp = await ref.read(databaseProvider).getAllProducts();
    return resp.isNotEmpty ? resp : null;
    
  }
}

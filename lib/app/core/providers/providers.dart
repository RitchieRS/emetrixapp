import 'package:emetrix_flutter/app/core/modules/pendientes/respository.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/service.dart';
import 'package:emetrix_flutter/app/core/modules/productos/repository.dart';
import 'package:emetrix_flutter/app/core/modules/productos/service.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/repository.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/service.dart';
import 'package:emetrix_flutter/app/core/modules/login/repository.dart';
import 'package:emetrix_flutter/app/core/modules/login/service.dart';
import 'package:emetrix_flutter/app/core/modules/stores/repository.dart';
import 'package:emetrix_flutter/app/core/modules/stores/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRepoProvider = Provider<LoginRepository>((ref) {
  return LoginRepository();
});

final loginServiceProvider = Provider<LoginService>((ref) {
  final respository = ref.watch(loginRepoProvider);
  return LoginService(respository);
});

//-----------------------------------

final sondeoRepoProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});

final sondeoServiceProvider = Provider<HomeService>((ref) {
  final respository = ref.watch(sondeoRepoProvider);
  return HomeService(respository);
});

//-----------------------------------

final storesRepoProvider = Provider<StoresRepository>((ref) {
  return StoresRepository();
});

final storesServiceProvider = Provider<StoresService>((ref) {
  final respository = ref.watch(storesRepoProvider);
  return StoresService(respository);
});

//-----------------------------------

final productosRepoProvider = Provider<ProductosRepository>((ref) {
  return ProductosRepository();
});

final productosServiceProvider = Provider<ProductosService>((ref) {
  final respository = ref.watch(productosRepoProvider);
  return ProductosService(respository);
});

//-----------------------------------

final pendingsRepoProvider = Provider<PendingsRepository>((ref) {
  return PendingsRepository();
});

final pendingsServiceProvider = Provider<PendingsService>((ref) {
  final respository = ref.watch(pendingsRepoProvider);
  return PendingsService(respository);
});

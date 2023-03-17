import 'package:emetrix_flutter/app/core/home/repository.dart';
import 'package:emetrix_flutter/app/core/home/service.dart';
import 'package:emetrix_flutter/app/core/login/repository.dart';
import 'package:emetrix_flutter/app/core/login/service.dart';
import 'package:emetrix_flutter/app/core/stores/repository.dart';
import 'package:emetrix_flutter/app/core/stores/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRepoProvider = Provider<LoginRepository>((ref) {
  return LoginRepository();
});

final loginServiceProvider = Provider<LoginService>((ref) {
  final respository = ref.watch(loginRepoProvider);
  return LoginService(respository);
});

//-----------------------------------

final homeRepoProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});

final homeServiceProvider = Provider<HomeService>((ref) {
  final respository = ref.watch(homeRepoProvider);
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

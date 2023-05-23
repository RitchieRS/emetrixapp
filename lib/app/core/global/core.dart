import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final logger = Logger();

const String baseUrl = 'https://emetrix.com.mx/tracker';

final dio = Dio(BaseOptions(
  baseUrl: baseUrl,
));

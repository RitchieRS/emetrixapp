import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

final logger = Logger();

const String baseUrl = 'https://emetrix.com.mx/tracker';

final dio = Dio(BaseOptions(
  baseUrl: baseUrl,
));

const uuidU = Uuid();

import 'package:dio/dio.dart';

final apiClient = Dio(
  BaseOptions(
    baseUrl: 'https://fake-api.tractian.com/',
    
  ),
);

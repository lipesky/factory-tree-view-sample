import 'package:dio/dio.dart';
import 'package:factory_tree_viewer/modules/shared/constant/fake_service_resources.dart';

final apiClient = Dio(
  BaseOptions(
    baseUrl: FakeServiceClientConstants.FAKE_SERVICE_API_URL,
  ),
);

import 'package:dio/dio.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/asset.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/company.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/location.dart';
import 'package:factory_tree_viewer/modules/shared/dio_client.dart';

class FakeService {
  static FakeService? _instance;

  factory FakeService() {
    _instance ??= FakeService.internal();
    return _instance!;
  }
  FakeService.internal();

  Future<List<Company>> getCompanies() async {
    final Response response = await apiClient.get('/companies');
    return ((response.data as List<dynamic>?) ?? [])
        .map((c) => Company.fromJson(c))
        .toList();
  }

  Future<List<Location>> getLocationsByCompanyId(String companyId) async {
    final Response response = await apiClient.get('/companies/$companyId/locations');
    return ((response.data as List<dynamic>?) ?? [])
        .map((c) => Location.fromJson(c))
        .toList();
  }

  Future<List<Asset>> getAssetsByCompanyId(String companyId) async {
    final Response response = await apiClient.get('/companies/$companyId/assets');
    return ((response.data as List<dynamic>?) ?? [])
        .map((c) => Asset.fromJson(c))
        .toList();
  }
}

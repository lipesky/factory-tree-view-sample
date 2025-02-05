import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/asset.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/company.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/location.dart';
import 'package:factory_tree_viewer/modules/shared/client/dio_client.dart';
import 'package:factory_tree_viewer/modules/shared/constant/fake_service_resources.dart';

class FakeService with FakeServicePath{
  static FakeService? _instance;

  factory FakeService() {
    _instance ??= FakeService.internal();
    return _instance!;
  }
  FakeService.internal();

  Future<List<Company>> getCompanies() async {
    final Response response = await apiClient.get(companiesPath);
    return ((response.data as List<dynamic>?) ?? [])
        .map((c) => Company.fromJson(c))
        .toList();
  }

  Future<List<Location>> getLocationsByCompanyId(String companyId) async {
    return await Isolate.run(()async{
      final Response response = await apiClient.get(locationsByCompanyPath(companyId));
      return ((response.data as List<dynamic>?) ?? [])
        .map((c) => Location.fromJson(c))
        .toList();
    });
  }

  Future<List<Asset>> getAssetsByCompanyId(String companyId) async {
    return await Isolate.run(()async{
      final Response response = await apiClient.get(assetsByCompanyIdPath(companyId));
      return ((response.data as List<dynamic>?) ?? [])
        .map((c) => Asset.fromJson(c))
        .toList();
    });
  }
}

// ignore_for_file: constant_identifier_names

class FakeServiceClientConstants {
  static const String FAKE_SERVICE_API_URL = 'https://fake-api.tractian.com';
}

mixin FakeServicePath {
  final String companiesPath = '/companies';
  String locationsByCompanyPath(String companyId) => '/companies/$companyId/locations';
  String assetsByCompanyIdPath(String companyId) => '/companies/$companyId/assets';
}
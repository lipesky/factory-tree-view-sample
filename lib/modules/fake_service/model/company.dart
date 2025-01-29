import 'package:freezed_annotation/freezed_annotation.dart';

part 'company.freezed.dart';
part 'company.g.dart';

@freezed
class Company with _$Company {
  const factory Company({
    required String id,
    required String name,
  }) = _Company;

  factory Company.fromJson(Map<String, Object?> json)
      => _$CompanyFromJson(json);
}
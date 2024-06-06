import 'package:json_annotation/json_annotation.dart';

part 'satuan_barang_get_data_dto.g.dart';

@JsonSerializable()
class SatuanBarangGetDataPayload {
  SatuanBarangGetDataPayload({
    required this.action,
    required this.filters,
  });

  factory SatuanBarangGetDataPayload.fromJson(Map<String, dynamic> json) => _$SatuanBarangGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$SatuanBarangGetDataPayloadToJson(this);

  final String action;
  final SatuanBarangGetFilter filters;
}

@JsonSerializable()
class SatuanBarangGetFilter {
  SatuanBarangGetFilter({
    required this.query,
  });

  factory SatuanBarangGetFilter.fromJson(Map<String, dynamic> json) => _$SatuanBarangGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$SatuanBarangGetFilterToJson(this);

  final int query;
}

@JsonSerializable()
class SatuanBarangGetDataResponse {
  SatuanBarangGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory SatuanBarangGetDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SatuanBarangGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SatuanBarangGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final List<SatuanBarangGetDataContent> data;
}

// @JsonSerializable()
// class SatuanBarangGetDataResult {
//   SatuanBarangGetDataResult({
//     required this.data,
//   });

//   factory SatuanBarangGetDataResult.fromJson(Map<String, dynamic> json) => _$SatuanBarangGetDataResultFromJson(json);

//   Map<String, dynamic> toJson() => _$SatuanBarangGetDataResultToJson(this);

//   final List<SatuanBarangGetDataContent> data;
// }

@JsonSerializable()
class SatuanBarangGetDataContent {
  SatuanBarangGetDataContent({
    this.vcNama = '',
    this.intNomor = 0,
    this.konversi = 0,
    this.urutan = 0,
    this.hargaPL = 0,
    this.hargaPLUSD = 0,
    this.hargaPLRMB = 0,
  });

  factory SatuanBarangGetDataContent.fromJson(Map<String, dynamic> json) => _$SatuanBarangGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$SatuanBarangGetDataContentToJson(this);
  @JsonKey(name: 'vcNama', includeIfNull: false)
  final String? vcNama;
  @JsonKey(name: 'intNomor', includeIfNull: false)
  final int? intNomor;
  @JsonKey(name: 'konversi', includeIfNull: false)
  final int? konversi;
  @JsonKey(name: 'urutan', includeIfNull: false)
  final int? urutan;
  @JsonKey(name: 'hargaPL', includeIfNull: false)
  final int? hargaPL;
  @JsonKey(name: 'hargaPLUSD', includeIfNull: false)
  final int? hargaPLUSD;
  @JsonKey(name: 'hargaPLRMB', includeIfNull: false)
  final int? hargaPLRMB;
}

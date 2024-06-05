import 'package:json_annotation/json_annotation.dart';

part 'posisi_stok_get_data_dto.g.dart';

@JsonSerializable()
class PosisiStokGetDataPayload {
  PosisiStokGetDataPayload({
    required this.action,
    required this.filters,
  });

  factory PosisiStokGetDataPayload.fromJson(Map<String, dynamic> json) => _$PosisiStokGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$PosisiStokGetDataPayloadToJson(this);

  final String action;
  final PosisiStokGetFilter filters;
}

@JsonSerializable()
class PosisiStokGetFilter {
  PosisiStokGetFilter({
    required this.limit,
    this.page = 1,
    required this.query,
  });

  factory PosisiStokGetFilter.fromJson(Map<String, dynamic> json) => _$PosisiStokGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$PosisiStokGetFilterToJson(this);

  final int limit;
  final int page;
  final PosisiStokQuery query;
}

@JsonSerializable()
class PosisiStokQuery {
  PosisiStokQuery({
    this.aKodeBarang = "",
    this.aNamaBeli = "",
    this.aKategori = "",
    this.aBrand = "",
    this.aTipe = "",
    this.aGroup = "",
    this.aGudang = "",
    this.aSatuan = "",
    this.aShade = "",
    this.aPanjang = 0,
    this.aLebar = 0,
    this.aTebal = 0,
    this.aTanggalAkhir= "",
    this.intNomorMUser = 2,
    this.aTampilkanNol = 0,
  });

  factory PosisiStokQuery.fromJson(Map<String, dynamic> json) => _$PosisiStokQueryFromJson(json);

  Map<String, dynamic> toJson() => _$PosisiStokQueryToJson(this);

  final String? aKodeBarang;
  final String? aNamaBeli;
  final String? aKategori;
  final String? aBrand;
  final String? aTipe;
  final String? aGroup;
  final String? aGudang;
  final String? aSatuan;
  final String? aShade;
  final int? aPanjang;
  final int? aLebar;
  final int? aTebal;
  final String? aTanggalAkhir;
  final int? intNomorMUser;
  final int? aTampilkanNol;
}

@JsonSerializable()
class PosisiStokGetDataResponse {
  PosisiStokGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory PosisiStokGetDataResponse.fromJson(Map<String, dynamic> json) => _$PosisiStokGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PosisiStokGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final List<PosisiStokGetDataContent> data;
}

@JsonSerializable()
class PosisiStokGetDataResult {
  PosisiStokGetDataResult({
    required this.data,
  });

  factory PosisiStokGetDataResult.fromJson(Map<String, dynamic> json) => _$PosisiStokGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$PosisiStokGetDataResultToJson(this);

  final List<PosisiStokGetDataContent> data;
}

@JsonSerializable()
class PosisiStokGetDataContent {
  PosisiStokGetDataContent({
     this.vcFilterKodeBarang = "",
     this.vcFilterNamaBeli ="",
     this.vcFilterBrand="",
     this.vcFilterTipe="",
     this.vcFilterGroup="",
     this.vcFilterKategori="",
    this.vcKodeBarang = "",
    this.vcNamaBeli = "",
    this.vcNamaJual = "",
    this.vcNamaSatuan1 = "",
    this.vcNamaSatuan2 = "",
    this.vcNamaSatuan3 = "",
    this.vcNamaGroup = "",
    this.vcNamaKategori = "",
    this.decJumlah1 = "",
    this.decJumlah2 = "",
    this.decJumlah3 = "",
    this.decPersediaan = "",
  });

  factory PosisiStokGetDataContent.fromJson(Map<String, dynamic> json) => _$PosisiStokGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$PosisiStokGetDataContentToJson(this);

  final String? vcFilterKodeBarang;
  final String? vcFilterNamaBeli;
  final String? vcFilterBrand;
  final String? vcFilterTipe;
  final String? vcFilterGroup;
  final String? vcFilterKategori;
  final String? vcKodeBarang;
  final String? vcNamaBeli;
  final String? vcNamaJual;
  final String? vcNamaSatuan1;
  final String? vcNamaSatuan2;
  final String? vcNamaSatuan3;
  final String? vcNamaGroup;
  final String? vcNamaKategori;
  final String? decJumlah1;
  final String? decJumlah2;
  final String? decJumlah3;
  final String? decPersediaan;
}

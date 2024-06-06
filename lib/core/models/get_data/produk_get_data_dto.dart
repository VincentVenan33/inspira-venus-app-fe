import 'package:json_annotation/json_annotation.dart';

part 'produk_get_data_dto.g.dart';

@JsonSerializable()
class BarangGetDataPayload {
  BarangGetDataPayload({
    required this.action,
    required this.filters,
    required this.search,
    required this.sort,
    required this.orderby,
  });

  factory BarangGetDataPayload.fromJson(Map<String, dynamic> json) => _$BarangGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$BarangGetDataPayloadToJson(this);

  final String action;
  final BarangGetFilter filters;
  final List<BarangGetSearch> search;
  final String sort;
  @JsonKey(name: 'order_by')
  final String orderby;
}

@JsonSerializable()
class BarangGetFilter {
  BarangGetFilter({
    required this.limit,
    required this.page,
    this.intNomor,
  });

  factory BarangGetFilter.fromJson(Map<String, dynamic> json) => _$BarangGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$BarangGetFilterToJson(this);

  final int limit;
  final int page;
  final int? intNomor;
}

@JsonSerializable()
class BarangGetSearch {
  BarangGetSearch({
    required this.term,
    this.key,
    this.query,
  });

  factory BarangGetSearch.fromJson(Map<String, dynamic> json) => _$BarangGetSearchFromJson(json);

  Map<String, dynamic> toJson() => _$BarangGetSearchToJson(this);

  final String term;
  final String? key;
  final String? query;
}

@JsonSerializable()
class BarangGetDataResponse {
  BarangGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory BarangGetDataResponse.fromJson(Map<String, dynamic> json) => _$BarangGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BarangGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final BarangGetDataResult data;
}

@JsonSerializable()
class BarangGetDataResult {
  BarangGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory BarangGetDataResult.fromJson(Map<String, dynamic> json) => _$BarangGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$BarangGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<BarangGetDataContent> data;
}

@JsonSerializable()
class BarangGetDataContent {
  BarangGetDataContent({
    required this.intNomor,
    required this.vcKode,
    required this.vcNamaBeli,
    this.decP = "",
    this.decL = "",
    this.decT = "",
    this.decLuas = "",
    this.decVolume = "",
    this.decStokMin = "",
    this.decBerat = 0,
    this.decHargaPL1 = "",
    this.vcNamaJual = "",
    this.brand = "",
    this.namagroup = "",
    this.tipe = "",
    this.grade = "",
    this.surface = "",
    this.satuan1 = "",
    this.satuan2 = "",
    this.satuan3 = "",
    this.kategori = "",
  });

  factory BarangGetDataContent.fromJson(Map<String, dynamic> json) => _$BarangGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$BarangGetDataContentToJson(this);

  final int intNomor;
  final String vcKode;
  final String vcNamaBeli;
  final String? decP;
  final String? decL;
  final String? decT;
  final String? decLuas;
  final String? decVolume;
  final String? decStokMin;
  final int? decBerat;
  final String? decHargaPL1;
  final String? vcNamaJual;
  final String? brand;
  final String? namagroup;
  final String? tipe;
  final String? grade;
  final String? surface;
  final String? satuan1;
  final String? satuan2;
  final String? satuan3;
  final String? kategori;
}

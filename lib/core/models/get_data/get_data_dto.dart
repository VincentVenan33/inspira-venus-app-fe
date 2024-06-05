import 'package:json_annotation/json_annotation.dart';

part 'get_data_dto.g.dart';

@JsonSerializable()
class GetDataPayload {
  GetDataPayload({
    required this.action,
    required this.filters,
    this.search,
  });

  factory GetDataPayload.fromJson(Map<String, dynamic> json) => _$GetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$GetDataPayloadToJson(this);

  final String action;
  final GetFilter filters;
  final List<GetSearch>? search;
}

@JsonSerializable()
class GetFilter {
  GetFilter({
    required this.limit,
    this.page = 1,
    this.sort,
    this.orderby,
    this.nomor,
  });

  factory GetFilter.fromJson(Map<String, dynamic> json) => _$GetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GetFilterToJson(this);

  final int limit;
  final int page;
  final String? sort;
  @JsonKey(name: 'order_by')
  final String? orderby;
  final int? nomor;
}

@JsonSerializable()
class GetSearch {
  GetSearch({
    required this.term,
    this.key,
    this.concat,
    this.query,
  });

  factory GetSearch.fromJson(Map<String, dynamic> json) => _$GetSearchFromJson(json);

  Map<String, dynamic> toJson() => _$GetSearchToJson(this);

  final String term;
  final String? key;
  final int? concat;
  final String? query;
}

@JsonSerializable()
class GetDataResponse {
  GetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory GetDataResponse.fromJson(Map<String, dynamic> json) => _$GetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final GetDataResult data;
}

@JsonSerializable()
class GetDataResult {
  GetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory GetDataResult.fromJson(Map<String, dynamic> json) => _$GetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<GetDataContent> data;
}

@JsonSerializable()
class GetDataContent {
  GetDataContent({
    required this.intNomor,
    required this.vcKode,
    required this.vcNama,
    this.vcKeterangan = "",
    this.intNomorMJenisCustomer = 0,
    this.intNomorMKlasifikasiCustomer = 0,
    this.intNomorMKotaPengiriman = 0,
    this.intNomorMKotaPenagihan = 0,
    this.intNomorMSales = 0,
    this.intNomorMArea = 0,
    this.vcKontak = "",
    this.vcNPWP = "",
    this.vcAlamatNPWP = "",
    this.vcAlamatPengiriman = "",
    this.vcAlamatPenagihan = "",
    this.vcTeleponPengiriman = "",
    this.vcTeleponPenagihan = "",
    this.vcHPPengiriman = "",
    this.vcHPPenagihan = "",
    this.vcFaxPengiriman = "",
    this.vcFaxPenagihan = "",
    this.vcEmailPenagihan = "",
    this.intPT = 0,
    this.intJT = 0,
    this.decPlafon = "",
    this.decLatitude = "",
    this.decLongitude = "",
    this.namasales = "",
    this.kodesales = "",
    this.namaarea = "",
    this.namakota = "",
    this.namaklasifikasicustomer = "",
  });

  factory GetDataContent.fromJson(Map<String, dynamic> json) => _$GetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$GetDataContentToJson(this);

  final int intNomor;
  final String vcKode;
  final String vcNama;
  final String? vcKeterangan;
  final int? intNomorMJenisCustomer;
  final int? intNomorMKlasifikasiCustomer;
  final int? intNomorMKotaPengiriman;
  final int? intNomorMKotaPenagihan;
  final int? intNomorMSales;
  final int? intNomorMArea;
  final String? vcKontak;
  final String? vcNPWP;
  final String? vcAlamatNPWP;
  final String? vcAlamatPengiriman;
  final String? vcAlamatPenagihan;
  final String? vcTeleponPengiriman;
  final String? vcTeleponPenagihan;
  final String? vcHPPengiriman;
  final String? vcHPPenagihan;
  final String? vcFaxPengiriman;
  final String? vcFaxPenagihan;
  final String? vcEmailPenagihan;
  final int? intPT;
  final int? intJT;
  final String? decPlafon;
  final String? decLatitude;
  final String? decLongitude;
  @JsonKey(name: 'nama_sales')
  final String? namasales;
  @JsonKey(name: 'kode_sales')
  final String? kodesales;
  @JsonKey(name: 'nama_area')
  final String? namaarea;
  @JsonKey(name: 'nama_kota')
  final String? namakota;
  @JsonKey(name: 'nama_klasifikasi_customer')
  final String? namaklasifikasicustomer;
}

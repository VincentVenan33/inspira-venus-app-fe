// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDataPayload _$GetDataPayloadFromJson(Map<String, dynamic> json) =>
    GetDataPayload(
      action: json['action'] as String,
      filters: GetFilter.fromJson(json['filters'] as Map<String, dynamic>),
      search: (json['search'] as List<dynamic>?)
          ?.map((e) => GetSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetDataPayloadToJson(GetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
      'search': instance.search,
    };

GetFilter _$GetFilterFromJson(Map<String, dynamic> json) => GetFilter(
      limit: json['limit'] as int,
      page: json['page'] as int? ?? 1,
      sort: json['sort'] as String?,
      orderby: json['order_by'] as String?,
      nomor: json['nomor'] as int?,
    );

Map<String, dynamic> _$GetFilterToJson(GetFilter instance) => <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'sort': instance.sort,
      'order_by': instance.orderby,
      'nomor': instance.nomor,
    };

GetSearch _$GetSearchFromJson(Map<String, dynamic> json) => GetSearch(
      term: json['term'] as String,
      key: json['key'] as String?,
      concat: json['concat'] as int?,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$GetSearchToJson(GetSearch instance) => <String, dynamic>{
      'term': instance.term,
      'key': instance.key,
      'concat': instance.concat,
      'query': instance.query,
    };

GetDataResponse _$GetDataResponseFromJson(Map<String, dynamic> json) =>
    GetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: GetDataResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDataResponseToJson(GetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

GetDataResult _$GetDataResultFromJson(Map<String, dynamic> json) =>
    GetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) => GetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetDataResultToJson(GetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

GetDataContent _$GetDataContentFromJson(Map<String, dynamic> json) =>
    GetDataContent(
      intNomor: json['intNomor'] as int,
      vcKode: json['vcKode'] as String,
      vcNama: json['vcNama'] as String,
      vcKeterangan: json['vcKeterangan'] as String? ?? "",
      intNomorMJenisCustomer: json['intNomorMJenisCustomer'] as int? ?? 0,
      intNomorMKlasifikasiCustomer:
          json['intNomorMKlasifikasiCustomer'] as int? ?? 0,
      intNomorMKotaPengiriman: json['intNomorMKotaPengiriman'] as int? ?? 0,
      intNomorMKotaPenagihan: json['intNomorMKotaPenagihan'] as int? ?? 0,
      intNomorMSales: json['intNomorMSales'] as int? ?? 0,
      intNomorMArea: json['intNomorMArea'] as int? ?? 0,
      vcKontak: json['vcKontak'] as String? ?? "",
      vcNPWP: json['vcNPWP'] as String? ?? "",
      vcAlamatNPWP: json['vcAlamatNPWP'] as String? ?? "",
      vcAlamatPengiriman: json['vcAlamatPengiriman'] as String? ?? "",
      vcAlamatPenagihan: json['vcAlamatPenagihan'] as String? ?? "",
      vcTeleponPengiriman: json['vcTeleponPengiriman'] as String? ?? "",
      vcTeleponPenagihan: json['vcTeleponPenagihan'] as String? ?? "",
      vcHPPengiriman: json['vcHPPengiriman'] as String? ?? "",
      vcHPPenagihan: json['vcHPPenagihan'] as String? ?? "",
      vcFaxPengiriman: json['vcFaxPengiriman'] as String? ?? "",
      vcFaxPenagihan: json['vcFaxPenagihan'] as String? ?? "",
      vcEmailPenagihan: json['vcEmailPenagihan'] as String? ?? "",
      intPT: json['intPT'] as int? ?? 0,
      intJT: json['intJT'] as int? ?? 0,
      decPlafon: json['decPlafon'] as String? ?? "",
      decLatitude: json['decLatitude'] as String? ?? "",
      decLongitude: json['decLongitude'] as String? ?? "",
      namasales: json['nama_sales'] as String? ?? "",
      kodesales: json['kode_sales'] as String? ?? "",
      namaarea: json['nama_area'] as String? ?? "",
      namakota: json['nama_kota'] as String? ?? "",
      namaklasifikasicustomer:
          json['nama_klasifikasi_customer'] as String? ?? "",
    );

Map<String, dynamic> _$GetDataContentToJson(GetDataContent instance) =>
    <String, dynamic>{
      'intNomor': instance.intNomor,
      'vcKode': instance.vcKode,
      'vcNama': instance.vcNama,
      'vcKeterangan': instance.vcKeterangan,
      'intNomorMJenisCustomer': instance.intNomorMJenisCustomer,
      'intNomorMKlasifikasiCustomer': instance.intNomorMKlasifikasiCustomer,
      'intNomorMKotaPengiriman': instance.intNomorMKotaPengiriman,
      'intNomorMKotaPenagihan': instance.intNomorMKotaPenagihan,
      'intNomorMSales': instance.intNomorMSales,
      'intNomorMArea': instance.intNomorMArea,
      'vcKontak': instance.vcKontak,
      'vcNPWP': instance.vcNPWP,
      'vcAlamatNPWP': instance.vcAlamatNPWP,
      'vcAlamatPengiriman': instance.vcAlamatPengiriman,
      'vcAlamatPenagihan': instance.vcAlamatPenagihan,
      'vcTeleponPengiriman': instance.vcTeleponPengiriman,
      'vcTeleponPenagihan': instance.vcTeleponPenagihan,
      'vcHPPengiriman': instance.vcHPPengiriman,
      'vcHPPenagihan': instance.vcHPPenagihan,
      'vcFaxPengiriman': instance.vcFaxPengiriman,
      'vcFaxPenagihan': instance.vcFaxPenagihan,
      'vcEmailPenagihan': instance.vcEmailPenagihan,
      'intPT': instance.intPT,
      'intJT': instance.intJT,
      'decPlafon': instance.decPlafon,
      'decLatitude': instance.decLatitude,
      'decLongitude': instance.decLongitude,
      'nama_sales': instance.namasales,
      'kode_sales': instance.kodesales,
      'nama_area': instance.namaarea,
      'nama_kota': instance.namakota,
      'nama_klasifikasi_customer': instance.namaklasifikasicustomer,
    };

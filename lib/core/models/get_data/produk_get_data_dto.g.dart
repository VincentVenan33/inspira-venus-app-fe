// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produk_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarangGetDataPayload _$BarangGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    BarangGetDataPayload(
      action: json['action'] as String,
      filters:
          BarangGetFilter.fromJson(json['filters'] as Map<String, dynamic>),
      search: (json['search'] as List<dynamic>)
          .map((e) => BarangGetSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
      sort: json['sort'] as String,
      orderby: json['order_by'] as String,
    );

Map<String, dynamic> _$BarangGetDataPayloadToJson(
        BarangGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
      'search': instance.search,
      'sort': instance.sort,
      'order_by': instance.orderby,
    };

BarangGetFilter _$BarangGetFilterFromJson(Map<String, dynamic> json) =>
    BarangGetFilter(
      limit: json['limit'] as int,
      page: json['page'] as int,
      intNomor: json['intNomor'] as int?,
    );

Map<String, dynamic> _$BarangGetFilterToJson(BarangGetFilter instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'intNomor': instance.intNomor,
    };

BarangGetSearch _$BarangGetSearchFromJson(Map<String, dynamic> json) =>
    BarangGetSearch(
      term: json['term'] as String,
      key: json['key'] as String?,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$BarangGetSearchToJson(BarangGetSearch instance) =>
    <String, dynamic>{
      'term': instance.term,
      'key': instance.key,
      'query': instance.query,
    };

BarangGetDataResponse _$BarangGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    BarangGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: BarangGetDataResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BarangGetDataResponseToJson(
        BarangGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

BarangGetDataResult _$BarangGetDataResultFromJson(Map<String, dynamic> json) =>
    BarangGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) => BarangGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BarangGetDataResultToJson(
        BarangGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

BarangGetDataContent _$BarangGetDataContentFromJson(
        Map<String, dynamic> json) =>
    BarangGetDataContent(
      intNomor: json['intNomor'] as int,
      vcKode: json['vcKode'] as String,
      vcNamaBeli: json['vcNamaBeli'] as String,
      decP: json['decP'] as String? ?? "",
      decL: json['decL'] as String? ?? "",
      decT: json['decT'] as String? ?? "",
      decLuas: json['decLuas'] as String? ?? "",
      decVolume: json['decVolume'] as String? ?? "",
      decStokMin: json['decStokMin'] as String? ?? "",
      decBerat: json['decBerat'] as int? ?? 0,
      decHargaPL1: json['decHargaPL1'] as String? ?? "",
      vcNamaJual: json['vcNamaJual'] as String? ?? "",
      brand: json['brand'] as String? ?? "",
      namagroup: json['namagroup'] as String? ?? "",
      tipe: json['tipe'] as String? ?? "",
      grade: json['grade'] as String? ?? "",
      surface: json['surface'] as String? ?? "",
      satuan1: json['satuan1'] as String? ?? "",
      satuan2: json['satuan2'] as String? ?? "",
      satuan3: json['satuan3'] as String? ?? "",
      kategori: json['kategori'] as String? ?? "",
    );

Map<String, dynamic> _$BarangGetDataContentToJson(
        BarangGetDataContent instance) =>
    <String, dynamic>{
      'intNomor': instance.intNomor,
      'vcKode': instance.vcKode,
      'vcNamaBeli': instance.vcNamaBeli,
      'decP': instance.decP,
      'decL': instance.decL,
      'decT': instance.decT,
      'decLuas': instance.decLuas,
      'decVolume': instance.decVolume,
      'decStokMin': instance.decStokMin,
      'decBerat': instance.decBerat,
      'decHargaPL1': instance.decHargaPL1,
      'vcNamaJual': instance.vcNamaJual,
      'brand': instance.brand,
      'namagroup': instance.namagroup,
      'tipe': instance.tipe,
      'grade': instance.grade,
      'surface': instance.surface,
      'satuan1': instance.satuan1,
      'satuan2': instance.satuan2,
      'satuan3': instance.satuan3,
      'kategori': instance.kategori,
    };

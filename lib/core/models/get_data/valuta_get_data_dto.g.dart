// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'valuta_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValutaGetDataPayload _$ValutaGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    ValutaGetDataPayload(
      action: json['action'] as String,
      filters:
          ValutaGetFilter.fromJson(json['filters'] as Map<String, dynamic>),
      search: (json['search'] as List<dynamic>?)
          ?.map((e) => ValutaGetSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ValutaGetDataPayloadToJson(
        ValutaGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
      'search': instance.search,
    };

ValutaGetFilter _$ValutaGetFilterFromJson(Map<String, dynamic> json) =>
    ValutaGetFilter(
      limit: json['limit'] as int,
      page: json['page'] as int? ?? 1,
      sort: json['sort'] as String?,
      orderby: json['order_by'] as String?,
      nomor: json['nomor'] as int?,
    );

Map<String, dynamic> _$ValutaGetFilterToJson(ValutaGetFilter instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'sort': instance.sort,
      'order_by': instance.orderby,
      'nomor': instance.nomor,
    };

ValutaGetSearch _$ValutaGetSearchFromJson(Map<String, dynamic> json) =>
    ValutaGetSearch(
      term: json['term'] as String,
      key: json['key'] as String?,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$ValutaGetSearchToJson(ValutaGetSearch instance) =>
    <String, dynamic>{
      'term': instance.term,
      'key': instance.key,
      'query': instance.query,
    };

ValutaGetDataResponse _$ValutaGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    ValutaGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: ValutaGetDataResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValutaGetDataResponseToJson(
        ValutaGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

ValutaGetDataResult _$ValutaGetDataResultFromJson(Map<String, dynamic> json) =>
    ValutaGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) => ValutaGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ValutaGetDataResultToJson(
        ValutaGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

ValutaGetDataContent _$ValutaGetDataContentFromJson(
        Map<String, dynamic> json) =>
    ValutaGetDataContent(
      intNomor: json['intNomor'] as int,
      vcNama: json['vcNama'] as String,
    );

Map<String, dynamic> _$ValutaGetDataContentToJson(
        ValutaGetDataContent instance) =>
    <String, dynamic>{
      'intNomor': instance.intNomor,
      'vcNama': instance.vcNama,
    };

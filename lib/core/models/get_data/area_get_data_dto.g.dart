// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaGetDataPayload _$AreaGetDataPayloadFromJson(Map<String, dynamic> json) =>
    AreaGetDataPayload(
      action: json['action'] as String,
      filters: AreaGetFilter.fromJson(json['filters'] as Map<String, dynamic>),
      search: (json['search'] as List<dynamic>?)
          ?.map((e) => AreaGetSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AreaGetDataPayloadToJson(AreaGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
      'search': instance.search,
    };

AreaGetFilter _$AreaGetFilterFromJson(Map<String, dynamic> json) =>
    AreaGetFilter(
      limit: json['limit'] as int,
      page: json['page'] as int? ?? 1,
      sort: json['sort'] as String?,
      orderby: json['order_by'] as String?,
      nomor: json['nomor'] as int?,
    );

Map<String, dynamic> _$AreaGetFilterToJson(AreaGetFilter instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'sort': instance.sort,
      'order_by': instance.orderby,
      'nomor': instance.nomor,
    };

AreaGetSearch _$AreaGetSearchFromJson(Map<String, dynamic> json) =>
    AreaGetSearch(
      term: json['term'] as String,
      key: json['key'] as String?,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$AreaGetSearchToJson(AreaGetSearch instance) =>
    <String, dynamic>{
      'term': instance.term,
      'key': instance.key,
      'query': instance.query,
    };

AreaGetDataResponse _$AreaGetDataResponseFromJson(Map<String, dynamic> json) =>
    AreaGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: AreaGetDataResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AreaGetDataResponseToJson(
        AreaGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

AreaGetDataResult _$AreaGetDataResultFromJson(Map<String, dynamic> json) =>
    AreaGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) => AreaGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AreaGetDataResultToJson(AreaGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

AreaGetDataContent _$AreaGetDataContentFromJson(Map<String, dynamic> json) =>
    AreaGetDataContent(
      intNomor: json['intNomor'] as int,
      vcNama: json['vcNama'] as String,
    );

Map<String, dynamic> _$AreaGetDataContentToJson(AreaGetDataContent instance) =>
    <String, dynamic>{
      'intNomor': instance.intNomor,
      'vcNama': instance.vcNama,
    };

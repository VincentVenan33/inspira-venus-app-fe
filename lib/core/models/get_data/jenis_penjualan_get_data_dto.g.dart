// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jenis_penjualan_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JenisPenjualanGetDataPayload _$JenisPenjualanGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    JenisPenjualanGetDataPayload(
      action: json['action'] as String,
      filters: JenisPenjualanGetFilter.fromJson(
          json['filters'] as Map<String, dynamic>),
      search: (json['search'] as List<dynamic>?)
          ?.map((e) =>
              JenisPenjualanGetSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JenisPenjualanGetDataPayloadToJson(
        JenisPenjualanGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
      'search': instance.search,
    };

JenisPenjualanGetFilter _$JenisPenjualanGetFilterFromJson(
        Map<String, dynamic> json) =>
    JenisPenjualanGetFilter(
      limit: json['limit'] as int,
      page: json['page'] as int? ?? 1,
      sort: json['sort'] as String?,
      orderby: json['order_by'] as String?,
      nomor: json['nomor'] as int?,
    );

Map<String, dynamic> _$JenisPenjualanGetFilterToJson(
        JenisPenjualanGetFilter instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'sort': instance.sort,
      'order_by': instance.orderby,
      'nomor': instance.nomor,
    };

JenisPenjualanGetSearch _$JenisPenjualanGetSearchFromJson(
        Map<String, dynamic> json) =>
    JenisPenjualanGetSearch(
      term: json['term'] as String,
      key: json['key'] as String?,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$JenisPenjualanGetSearchToJson(
        JenisPenjualanGetSearch instance) =>
    <String, dynamic>{
      'term': instance.term,
      'key': instance.key,
      'query': instance.query,
    };

JenisPenjualanGetDataResponse _$JenisPenjualanGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    JenisPenjualanGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: JenisPenjualanGetDataResult.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JenisPenjualanGetDataResponseToJson(
        JenisPenjualanGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

JenisPenjualanGetDataResult _$JenisPenjualanGetDataResultFromJson(
        Map<String, dynamic> json) =>
    JenisPenjualanGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              JenisPenjualanGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JenisPenjualanGetDataResultToJson(
        JenisPenjualanGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

JenisPenjualanGetDataContent _$JenisPenjualanGetDataContentFromJson(
        Map<String, dynamic> json) =>
    JenisPenjualanGetDataContent(
      intNomor: json['intNomor'] as int,
      vcNama: json['vcNama'] as String,
    );

Map<String, dynamic> _$JenisPenjualanGetDataContentToJson(
        JenisPenjualanGetDataContent instance) =>
    <String, dynamic>{
      'intNomor': instance.intNomor,
      'vcNama': instance.vcNama,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'satuan_barang_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SatuanBarangGetDataPayload _$SatuanBarangGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    SatuanBarangGetDataPayload(
      action: json['action'] as String,
      filters: SatuanBarangGetFilter.fromJson(
          json['filters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SatuanBarangGetDataPayloadToJson(
        SatuanBarangGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
    };

SatuanBarangGetFilter _$SatuanBarangGetFilterFromJson(
        Map<String, dynamic> json) =>
    SatuanBarangGetFilter(
      query: json['query'] as int,
    );

Map<String, dynamic> _$SatuanBarangGetFilterToJson(
        SatuanBarangGetFilter instance) =>
    <String, dynamic>{
      'query': instance.query,
    };

SatuanBarangGetDataResponse _$SatuanBarangGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    SatuanBarangGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              SatuanBarangGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SatuanBarangGetDataResponseToJson(
        SatuanBarangGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

SatuanBarangGetDataContent _$SatuanBarangGetDataContentFromJson(
        Map<String, dynamic> json) =>
    SatuanBarangGetDataContent(
      vcNama: json['vcNama'] as String? ?? '',
      intNomor: json['intNomor'] as int? ?? 0,
      konversi: json['konversi'] as int? ?? 0,
      urutan: json['urutan'] as int? ?? 0,
      hargaPL: json['hargaPL'] as int? ?? 0,
      hargaPLUSD: json['hargaPLUSD'] as int? ?? 0,
      hargaPLRMB: json['hargaPLRMB'] as int? ?? 0,
    );

Map<String, dynamic> _$SatuanBarangGetDataContentToJson(
    SatuanBarangGetDataContent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('vcNama', instance.vcNama);
  writeNotNull('intNomor', instance.intNomor);
  writeNotNull('konversi', instance.konversi);
  writeNotNull('urutan', instance.urutan);
  writeNotNull('hargaPL', instance.hargaPL);
  writeNotNull('hargaPLUSD', instance.hargaPLUSD);
  writeNotNull('hargaPLRMB', instance.hargaPLRMB);
  return val;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posisi_stok_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PosisiStokGetDataPayload _$PosisiStokGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    PosisiStokGetDataPayload(
      action: json['action'] as String,
      filters:
          PosisiStokGetFilter.fromJson(json['filters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PosisiStokGetDataPayloadToJson(
        PosisiStokGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
    };

PosisiStokGetFilter _$PosisiStokGetFilterFromJson(Map<String, dynamic> json) =>
    PosisiStokGetFilter(
      limit: json['limit'] as int,
      page: json['page'] as int? ?? 1,
      query: PosisiStokQuery.fromJson(json['query'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PosisiStokGetFilterToJson(
        PosisiStokGetFilter instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'query': instance.query,
    };

PosisiStokQuery _$PosisiStokQueryFromJson(Map<String, dynamic> json) =>
    PosisiStokQuery(
      aKodeBarang: json['aKodeBarang'] as String? ?? "",
      aNamaBeli: json['aNamaBeli'] as String? ?? "",
      aKategori: json['aKategori'] as String? ?? "",
      aBrand: json['aBrand'] as String? ?? "",
      aTipe: json['aTipe'] as String? ?? "",
      aGroup: json['aGroup'] as String? ?? "",
      aGudang: json['aGudang'] as String? ?? "",
      aSatuan: json['aSatuan'] as String? ?? "",
      aShade: json['aShade'] as String? ?? "",
      aPanjang: json['aPanjang'] as int? ?? 0,
      aLebar: json['aLebar'] as int? ?? 0,
      aTebal: json['aTebal'] as int? ?? 0,
      aTanggalAkhir: json['aTanggalAkhir'] as String? ?? "",
      intNomorMUser: json['intNomorMUser'] as int? ?? 2,
      aTampilkanNol: json['aTampilkanNol'] as int? ?? 0,
    );

Map<String, dynamic> _$PosisiStokQueryToJson(PosisiStokQuery instance) =>
    <String, dynamic>{
      'aKodeBarang': instance.aKodeBarang,
      'aNamaBeli': instance.aNamaBeli,
      'aKategori': instance.aKategori,
      'aBrand': instance.aBrand,
      'aTipe': instance.aTipe,
      'aGroup': instance.aGroup,
      'aGudang': instance.aGudang,
      'aSatuan': instance.aSatuan,
      'aShade': instance.aShade,
      'aPanjang': instance.aPanjang,
      'aLebar': instance.aLebar,
      'aTebal': instance.aTebal,
      'aTanggalAkhir': instance.aTanggalAkhir,
      'intNomorMUser': instance.intNomorMUser,
      'aTampilkanNol': instance.aTampilkanNol,
    };

PosisiStokGetDataResponse _$PosisiStokGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    PosisiStokGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              PosisiStokGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PosisiStokGetDataResponseToJson(
        PosisiStokGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

PosisiStokGetDataResult _$PosisiStokGetDataResultFromJson(
        Map<String, dynamic> json) =>
    PosisiStokGetDataResult(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              PosisiStokGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PosisiStokGetDataResultToJson(
        PosisiStokGetDataResult instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

PosisiStokGetDataContent _$PosisiStokGetDataContentFromJson(
        Map<String, dynamic> json) =>
    PosisiStokGetDataContent(
      vcFilterKodeBarang: json['vcFilterKodeBarang'] as String? ?? "",
      vcFilterNamaBeli: json['vcFilterNamaBeli'] as String? ?? "",
      vcFilterBrand: json['vcFilterBrand'] as String? ?? "",
      vcFilterTipe: json['vcFilterTipe'] as String? ?? "",
      vcFilterGroup: json['vcFilterGroup'] as String? ?? "",
      vcFilterKategori: json['vcFilterKategori'] as String? ?? "",
      vcKodeBarang: json['vcKodeBarang'] as String? ?? "",
      vcNamaBeli: json['vcNamaBeli'] as String? ?? "",
      vcNamaJual: json['vcNamaJual'] as String? ?? "",
      vcNamaSatuan1: json['vcNamaSatuan1'] as String? ?? "",
      vcNamaSatuan2: json['vcNamaSatuan2'] as String? ?? "",
      vcNamaSatuan3: json['vcNamaSatuan3'] as String? ?? "",
      vcNamaGroup: json['vcNamaGroup'] as String? ?? "",
      vcNamaKategori: json['vcNamaKategori'] as String? ?? "",
      decJumlah1: json['decJumlah1'] as String? ?? "",
      decJumlah2: json['decJumlah2'] as String? ?? "",
      decJumlah3: json['decJumlah3'] as String? ?? "",
      decPersediaan: json['decPersediaan'] as String? ?? "",
    );

Map<String, dynamic> _$PosisiStokGetDataContentToJson(
        PosisiStokGetDataContent instance) =>
    <String, dynamic>{
      'vcFilterKodeBarang': instance.vcFilterKodeBarang,
      'vcFilterNamaBeli': instance.vcFilterNamaBeli,
      'vcFilterBrand': instance.vcFilterBrand,
      'vcFilterTipe': instance.vcFilterTipe,
      'vcFilterGroup': instance.vcFilterGroup,
      'vcFilterKategori': instance.vcFilterKategori,
      'vcKodeBarang': instance.vcKodeBarang,
      'vcNamaBeli': instance.vcNamaBeli,
      'vcNamaJual': instance.vcNamaJual,
      'vcNamaSatuan1': instance.vcNamaSatuan1,
      'vcNamaSatuan2': instance.vcNamaSatuan2,
      'vcNamaSatuan3': instance.vcNamaSatuan3,
      'vcNamaGroup': instance.vcNamaGroup,
      'vcNamaKategori': instance.vcNamaKategori,
      'decJumlah1': instance.decJumlah1,
      'decJumlah2': instance.decJumlah2,
      'decJumlah3': instance.decJumlah3,
      'decPersediaan': instance.decPersediaan,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_jual_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderJualDetailPayload _$CreateOrderJualDetailPayloadFromJson(
        Map<String, dynamic> json) =>
    CreateOrderJualDetailPayload(
      action: json['action'] as String,
      requestData: CreateOrderJualDetailRequest.fromJson(
          json['requestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOrderJualDetailPayloadToJson(
        CreateOrderJualDetailPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'requestData': instance.requestData,
    };

CreateOrderJualDetailRequest _$CreateOrderJualDetailRequestFromJson(
        Map<String, dynamic> json) =>
    CreateOrderJualDetailRequest(
      formatcode: json['format_code'] as String?,
      intNomorHeader: json['intNomorHeader'] as int?,
      intNomorDetail: json['intNomorDetail'] as int?,
      intNomorMBarang: json['intNomorMBarang'] as int?,
      intNomorMSatuan1: json['intNomorMSatuan1'] as int?,
      decJumlah1: json['decJumlah1'] as int?,
      decNetto: json['decNetto'] as int?,
      decDisc1: json['decDisc1'] as int?,
      decDisc2: json['decDisc2'] as int?,
      decDisc3: json['decDisc3'] as int?,
      decJumlahUnit: json['decJumlahUnit'] as int?,
      dtTanggal: json['dtTanggal'] as String,
      decHarga: json['decHarga'] as int?,
      decSubTotal: json['decSubTotal'] as int,
      decBerat: json['decBerat'] as int,
    );

Map<String, dynamic> _$CreateOrderJualDetailRequestToJson(
        CreateOrderJualDetailRequest instance) =>
    <String, dynamic>{
      'format_code': instance.formatcode,
      'intNomorHeader': instance.intNomorHeader,
      'intNomorDetail': instance.intNomorDetail,
      'intNomorMBarang': instance.intNomorMBarang,
      'intNomorMSatuan1': instance.intNomorMSatuan1,
      'decJumlah1': instance.decJumlah1,
      'decNetto': instance.decNetto,
      'decDisc1': instance.decDisc1,
      'decDisc2': instance.decDisc2,
      'decDisc3': instance.decDisc3,
      'decJumlahUnit': instance.decJumlahUnit,
      'dtTanggal': instance.dtTanggal,
      'decHarga': instance.decHarga,
      'decSubTotal': instance.decSubTotal,
      'decBerat': instance.decBerat,
    };

CreateOrderJualDetailResponse _$CreateOrderJualDetailResponseFromJson(
        Map<String, dynamic> json) =>
    CreateOrderJualDetailResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: SetOrderJualDetailDataContent.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOrderJualDetailResponseToJson(
        CreateOrderJualDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

SetOrderJualDetailDataContent _$SetOrderJualDetailDataContentFromJson(
        Map<String, dynamic> json) =>
    SetOrderJualDetailDataContent(
      kode: json['kode'] as String,
      nomorthOrderJualDetail: json['nomorthOrderJualDetail'] as int?,
      nomormhbarang: json['nomormhbarang'] as int?,
      nomormhsatuan: json['nomormhsatuan'] as int?,
      qty: json['qty'] as int?,
      netto: json['netto'] as int?,
      disctotal: json['disc_total'] as int?,
      discdirect: json['disc_direct'] as int?,
      disc3: json['disc_3'] as int?,
      disc2: json['disc_2'] as int?,
      disc1: json['disc_1'] as int?,
      satuanqty: json['satuan_qty'] as String,
      isi: json['isi'] as int?,
      satuanisi: json['satuan_isi'] as String,
      harga: json['harga'] as int?,
      subtotal: json['subtotal'] as String,
      konversisatuan: json['konversi_satuan'] as String,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SetOrderJualDetailDataContentToJson(
        SetOrderJualDetailDataContent instance) =>
    <String, dynamic>{
      'kode': instance.kode,
      'nomorthOrderJualDetail': instance.nomorthOrderJualDetail,
      'nomormhbarang': instance.nomormhbarang,
      'nomormhsatuan': instance.nomormhsatuan,
      'qty': instance.qty,
      'netto': instance.netto,
      'disc_total': instance.disctotal,
      'disc_direct': instance.discdirect,
      'disc_3': instance.disc3,
      'disc_2': instance.disc2,
      'disc_1': instance.disc1,
      'satuan_qty': instance.satuanqty,
      'isi': instance.isi,
      'satuan_isi': instance.satuanisi,
      'harga': instance.harga,
      'subtotal': instance.subtotal,
      'konversi_satuan': instance.konversisatuan,
      'id': instance.id,
    };

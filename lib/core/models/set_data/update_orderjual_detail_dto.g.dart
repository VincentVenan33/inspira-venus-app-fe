// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_orderjual_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrderJualDetailPayload _$UpdateOrderJualDetailPayloadFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualDetailPayload(
      action: json['action'] as String,
      requestData: UpdateOrderJualDetailRequest.fromJson(
          json['requestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateOrderJualDetailPayloadToJson(
        UpdateOrderJualDetailPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'requestData': instance.requestData,
    };

UpdateOrderJualDetailRequest _$UpdateOrderJualDetailRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualDetailRequest(
      intNomorHeader: json['intNomorHeader'] as int?,
      intNomorDetail: json['intNomorDetail'] as int?,
      intNomorMSatuan1: json['intNomorMSatuan1'] as int?,
      decJumlah1: json['decJumlah1'] as int?,
      decNetto: json['decNetto'] as int?,
      decDisc1: json['decDisc1'] as int?,
      decDisc2: json['decDisc2'] as int?,
      decDisc3: json['decDisc3'] as int?,
      decJumlahUnit: json['decJumlahUnit'] as int?,
      decHarga: json['decHarga'] as int?,
      decSubTotal: json['decSubTotal'] as int,
      decBerat: json['decBerat'] as int,
    );

Map<String, dynamic> _$UpdateOrderJualDetailRequestToJson(
        UpdateOrderJualDetailRequest instance) =>
    <String, dynamic>{
      'intNomorHeader': instance.intNomorHeader,
      'intNomorDetail': instance.intNomorDetail,
      'intNomorMSatuan1': instance.intNomorMSatuan1,
      'decJumlah1': instance.decJumlah1,
      'decNetto': instance.decNetto,
      'decDisc1': instance.decDisc1,
      'decDisc2': instance.decDisc2,
      'decDisc3': instance.decDisc3,
      'decJumlahUnit': instance.decJumlahUnit,
      'decHarga': instance.decHarga,
      'decSubTotal': instance.decSubTotal,
      'decBerat': instance.decBerat,
    };

UpdateOrderJualDetailResponse _$UpdateOrderJualDetailResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualDetailResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: json['data'] as int?,
    );

Map<String, dynamic> _$UpdateOrderJualDetailResponseToJson(
        UpdateOrderJualDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

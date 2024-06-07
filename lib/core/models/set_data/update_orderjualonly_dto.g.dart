// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_orderjualonly_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrderJualOnlyPayload _$UpdateOrderJualOnlyPayloadFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualOnlyPayload(
      action: json['action'] as String,
      requestData: UpdateOrderJualOnlyRequest.fromJson(
          json['requestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateOrderJualOnlyPayloadToJson(
        UpdateOrderJualOnlyPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'requestData': instance.requestData,
    };

UpdateOrderJualOnlyRequest _$UpdateOrderJualOnlyRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualOnlyRequest(
      dtTanggal: json['dtTanggal'] as String,
      dtTanggalKirim: json['dtTanggalKirim'] as String,
      intNomorMJenisPenjualan: json['intNomorMJenisPenjualan'] as int,
      intNomorMValuta: json['intNomorMValuta'] as int,
      intNomorMGudang: json['intNomorMGudang'] as int,
      intNomorMCustomer: json['intNomorMCustomer'] as int,
      intNomorMSales: json['intNomorMSales'] as int,
      intNomorMArea: json['intNomorMArea'] as int,
      intJenis: json['intJenis'] as int,
      intJTHari: json['intJTHari'] as int,
      decKurs: json['decKurs'] as int,
      decUM1: json['decUM1'] as int,
      decUM2: json['decUM2'] as int,
      decUM3: json['decUM3'] as int,
      decTotalUMC: json['decTotalUMC'] as int,
      decTotalBiaya: json['decTotalBiaya'] as int,
      decSubTotal: json['decSubTotal'] as int,
      decPPN: json['decPPN'] as int,
      decPPNNominal: json['decPPNNominal'] as int,
      decDPP: json['decDPP'] as int,
      decSisa: json['decSisa'] as int,
      intEksport: json['intEksport'] as int,
    );

Map<String, dynamic> _$UpdateOrderJualOnlyRequestToJson(
        UpdateOrderJualOnlyRequest instance) =>
    <String, dynamic>{
      'dtTanggal': instance.dtTanggal,
      'dtTanggalKirim': instance.dtTanggalKirim,
      'intNomorMJenisPenjualan': instance.intNomorMJenisPenjualan,
      'intNomorMValuta': instance.intNomorMValuta,
      'intNomorMGudang': instance.intNomorMGudang,
      'intNomorMCustomer': instance.intNomorMCustomer,
      'intNomorMSales': instance.intNomorMSales,
      'intNomorMArea': instance.intNomorMArea,
      'intJenis': instance.intJenis,
      'decKurs': instance.decKurs,
      'intJTHari': instance.intJTHari,
      'decUM1': instance.decUM1,
      'decUM2': instance.decUM2,
      'decUM3': instance.decUM3,
      'decTotalUMC': instance.decTotalUMC,
      'decTotalBiaya': instance.decTotalBiaya,
      'decSubTotal': instance.decSubTotal,
      'decPPN': instance.decPPN,
      'decPPNNominal': instance.decPPNNominal,
      'decDPP': instance.decDPP,
      'decSisa': instance.decSisa,
      'intEksport': instance.intEksport,
    };

UpdateOrderJualOnlyResponse _$UpdateOrderJualOnlyResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderJualOnlyResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: json['data'] as int?,
    );

Map<String, dynamic> _$UpdateOrderJualOnlyResponseToJson(
        UpdateOrderJualOnlyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

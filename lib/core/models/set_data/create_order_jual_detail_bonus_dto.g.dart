// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_jual_detail_bonus_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderJualDetailBonusPayload _$CreateOrderJualDetailBonusPayloadFromJson(
        Map<String, dynamic> json) =>
    CreateOrderJualDetailBonusPayload(
      action: json['action'] as String,
      requestData: CreateOrderJualDetailBonusRequest.fromJson(
          json['requestData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOrderJualDetailBonusPayloadToJson(
        CreateOrderJualDetailBonusPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'requestData': instance.requestData,
    };

CreateOrderJualDetailBonusRequest _$CreateOrderJualDetailBonusRequestFromJson(
        Map<String, dynamic> json) =>
    CreateOrderJualDetailBonusRequest(
      formatcode: json['format_code'] as String?,
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
      detail: (json['detail'] as List<dynamic>)
          .map((e) => CreateDetailRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateOrderJualDetailBonusRequestToJson(
        CreateOrderJualDetailBonusRequest instance) =>
    <String, dynamic>{
      'format_code': instance.formatcode,
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
      'detail': instance.detail,
    };

CreateDetailRequest _$CreateDetailRequestFromJson(Map<String, dynamic> json) =>
    CreateDetailRequest(
      orderjualdetail: (json['order_jual_detail'] as List<dynamic>)
          .map((e) =>
              CreateOrderJualDetailRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateDetailRequestToJson(
        CreateDetailRequest instance) =>
    <String, dynamic>{
      'order_jual_detail': instance.orderjualdetail,
    };

CreateOrderJualDetailRequest _$CreateOrderJualDetailRequestFromJson(
        Map<String, dynamic> json) =>
    CreateOrderJualDetailRequest(
      kodeBarang: json['KodeBarang'] as String?,
      barang: json['Barang'] as String?,
      satuan1: json['Satuan1'] as String?,
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
      'KodeBarang': instance.kodeBarang,
      'Barang': instance.barang,
      'Satuan1': instance.satuan1,
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

CreateOrderJualBonusDetailRequest _$CreateOrderJualBonusDetailRequestFromJson(
        Map<String, dynamic> json) =>
    CreateOrderJualBonusDetailRequest(
      nomormhbarang: json['nomormhbarang'] as int,
      nomormhsatuan: json['nomormhsatuan'] as int,
      qtyunit: json['qty_unit'] as int,
      satuanunit: json['satuan_unit'] as String,
      qtyisi: json['qty_isi'] as int,
      satuanisi: json['satuan_isi'] as String,
      konversisatuan: json['konversi_satuan'] as int,
      selectedsatuan: json['selected_satuan'] as int,
    );

Map<String, dynamic> _$CreateOrderJualBonusDetailRequestToJson(
        CreateOrderJualBonusDetailRequest instance) =>
    <String, dynamic>{
      'nomormhbarang': instance.nomormhbarang,
      'nomormhsatuan': instance.nomormhsatuan,
      'qty_unit': instance.qtyunit,
      'satuan_unit': instance.satuanunit,
      'qty_isi': instance.qtyisi,
      'satuan_isi': instance.satuanisi,
      'konversi_satuan': instance.konversisatuan,
      'selected_satuan': instance.selectedsatuan,
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
      nomormhcustomer: json['nomormhcustomer'] as String,
      ppnprosentase: json['ppn_prosentase'] as String,
      statusppn: json['status_ppn'] as int,
      tanggal: json['tanggal'] as String,
      dibuatoleh: json['dibuat_oleh'] as int,
      diubahpada: json['diubah_pada'] as String,
      dibuatpada: json['dibuat_pada'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$SetOrderJualDetailDataContentToJson(
        SetOrderJualDetailDataContent instance) =>
    <String, dynamic>{
      'kode': instance.kode,
      'nomormhcustomer': instance.nomormhcustomer,
      'ppn_prosentase': instance.ppnprosentase,
      'status_ppn': instance.statusppn,
      'tanggal': instance.tanggal,
      'dibuat_oleh': instance.dibuatoleh,
      'diubah_pada': instance.diubahpada,
      'dibuat_pada': instance.dibuatpada,
      'id': instance.id,
    };

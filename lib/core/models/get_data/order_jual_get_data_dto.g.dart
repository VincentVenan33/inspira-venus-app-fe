// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_jual_get_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderJualGetDataPayload _$OrderJualGetDataPayloadFromJson(
        Map<String, dynamic> json) =>
    OrderJualGetDataPayload(
      action: json['action'] as String,
      filters:
          OrderJualGetFilter.fromJson(json['filters'] as Map<String, dynamic>),
      search: (json['search'] as List<dynamic>)
          .map((e) => OrderJualGetSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderJualGetDataPayloadToJson(
        OrderJualGetDataPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'filters': instance.filters,
      'search': instance.search,
    };

OrderJualGetFilter _$OrderJualGetFilterFromJson(Map<String, dynamic> json) =>
    OrderJualGetFilter(
      limit: json['limit'] as int,
      page: json['page'] as int,
      startdate: json['start_date'] as String?,
      enddate: json['end_date'] as String?,
      sort: json['sort'] as String?,
      intNomor: json['intNomor'] as int?,
      orderby: json['order_by'] as String?,
    );

Map<String, dynamic> _$OrderJualGetFilterToJson(OrderJualGetFilter instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'intNomor': instance.intNomor,
      'start_date': instance.startdate,
      'end_date': instance.enddate,
      'sort': instance.sort,
      'order_by': instance.orderby,
    };

OrderJualGetSearch _$OrderJualGetSearchFromJson(Map<String, dynamic> json) =>
    OrderJualGetSearch(
      term: json['term'] as String?,
      key: json['key'] as String?,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$OrderJualGetSearchToJson(OrderJualGetSearch instance) =>
    <String, dynamic>{
      'term': instance.term,
      'key': instance.key,
      'query': instance.query,
    };

OrderJualGetDataResponse _$OrderJualGetDataResponseFromJson(
        Map<String, dynamic> json) =>
    OrderJualGetDataResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data:
          OrderJualGetDataResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderJualGetDataResponseToJson(
        OrderJualGetDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

OrderJualGetDataResult _$OrderJualGetDataResultFromJson(
        Map<String, dynamic> json) =>
    OrderJualGetDataResult(
      draw: json['draw'] as String?,
      recordsTotal: json['recordsTotal'] as int?,
      recordsFiltered: json['recordsFiltered'] as int?,
      totalrows: json['total_rows'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              OrderJualGetDataContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderJualGetDataResultToJson(
        OrderJualGetDataResult instance) =>
    <String, dynamic>{
      'draw': instance.draw,
      'recordsTotal': instance.recordsTotal,
      'recordsFiltered': instance.recordsFiltered,
      'total_rows': instance.totalrows,
      'data': instance.data,
    };

OrderJualGetDataContent _$OrderJualGetDataContentFromJson(
        Map<String, dynamic> json) =>
    OrderJualGetDataContent(
      intNomor: json['intNomor'] as int? ?? 0,
      intNomorHeader: json['intNomorHeader'] as int? ?? 0,
      intNomorDetail: json['intNomorDetail'] as int? ?? 0,
      intNomorMBarang: json['intNomorMBarang'] as int? ?? 0,
      intNomorMBarangJadi: json['intNomorMBarangJadi'] as int? ?? 0,
      intNomorMSatuan: json['intNomorMSatuan'] as int? ?? 0,
      intNomorMSatuan1: json['intNomorMSatuan1'] as int? ?? 0,
      intNomorMSatuanUnit: json['intNomorMSatuanUnit'] as int? ?? 0,
      vcKode: json['vcKode'] as String? ?? "",
      intTOP: json['intTOP'] as int? ?? 0,
      dtTanggal: json['dtTanggal'] as String? ?? "",
      dtTanggalKirim: json['dtTanggalKirim'] as String? ?? "",
      intJTHari: json['intJTHari'] as int? ?? 0,
      vcKeterangan: json['vcKeterangan'] as String? ?? "",
      vcKeteranganFJ: json['vcKeteranganFJ'] as String? ?? "",
      vcKeteranganKW: json['vcKeteranganKW'] as String? ?? "",
      intJenisOJ: json['intJenisOJ'] as int? ?? 0,
      intJenis: json['intJenis'] as int? ?? 0,
      intGabungan: json['intGabungan'] as int? ?? 0,
      intNomorMCabang: json['intNomorMCabang'] as int? ?? 0,
      intNomorMCustomer: json['intNomorMCustomer'] as int? ?? 0,
      intNomorMSales: json['intNomorMSales'] as int? ?? 0,
      intNomorMJenisPenjualan: json['intNomorMJenisPenjualan'] as int? ?? 0,
      intNomorMValuta: json['intNomorMValuta'] as int? ?? 0,
      intNomorMProyek: json['intNomorMProyek'] as int? ?? 0,
      intBiaya: json['intBiaya'] as int? ?? 0,
      decSubTotal: (json['decSubTotal'] as num?)?.toDouble() ?? 0,
      decKurs: (json['decKurs'] as num?)?.toDouble() ?? 0,
      decDisc: (json['decDisc'] as num?)?.toDouble() ?? 0,
      decDiscNominal: (json['decDiscNominal'] as num?)?.toDouble() ?? 0,
      decPPN: (json['decPPN'] as num?)?.toDouble() ?? 0,
      decPPNNominal: (json['decPPNNominal'] as num?)?.toDouble() ?? 0,
      decTotal: (json['decTotal'] as num?)?.toDouble() ?? 0,
      decTotalLama: (json['decTotalLama'] as num?)?.toDouble() ?? 0,
      decDPP: (json['decDPP'] as num?)?.toDouble() ?? 0,
      decTotalUMC: (json['decTotalUMC'] as num?)?.toDouble() ?? 0,
      decSisa: (json['decSisa'] as num?)?.toDouble() ?? 0,
      decTotalBiaya: (json['decTotalBiaya'] as num?)?.toDouble() ?? 0,
      decTotalBiayaInternal:
          (json['decTotalBiayaInternal'] as num?)?.toDouble() ?? 0,
      decTotalBiayaEstimasi:
          (json['decTotalBiayaEstimasi'] as num?)?.toDouble() ?? 0,
      intApproved: json['intApproved'] as int? ?? 0,
      intApproveUserID: json['intApproveUserID'] as int? ?? 0,
      dtApproveTime: json['dtApproveTime'] as String? ?? "",
      vcPenerima: json['vcPenerima'] as String? ?? "",
      vcAlamat: json['vcAlamat'] as String? ?? "",
      intNomorMKota: json['intNomorMKota'] as int? ?? 0,
      vcTelepon: json['vcTelepon'] as String? ?? "",
      vcFax: json['vcFax'] as String? ?? "",
      vcHP: json['vcHP'] as String? ?? "",
      vcEmail: json['vcEmail'] as String? ?? "",
      intNomorMUserApprovedBy: json['intNomorMUserApprovedBy'] as int? ?? 0,
      intNomorMGudang: json['intNomorMGudang'] as int? ?? 0,
      intDraft: json['intDraft'] as int? ?? 0,
      intPending: json['intPending'] as int? ?? 0,
      intSample: json['intSample'] as int? ?? 0,
      decUM1: (json['decUM1'] as num?)?.toDouble() ?? 0,
      decUM2: (json['decUM2'] as num?)?.toDouble() ?? 0,
      decUM3: (json['decUM3'] as num?)?.toDouble() ?? 0,
      intValidasiUserID: json['intValidasiUserID'] as int? ?? 0,
      dtValidasiTime: json['dtValidasiTime'] as String? ?? "",
      intUnValidasiUserID: json['intUnValidasiUserID'] as int? ?? 0,
      dtUnValidasiTime: json['dtUnValidasiTime'] as String? ?? "",
      intNomorMArea: json['intNomorMArea'] as int? ?? 0,
      vcAlasanValidasi: json['vcAlasanValidasi'] as String? ?? "",
      vcAlasanBatalValidasi: json['vcAlasanBatalValidasi'] as String? ?? "",
      intEksport: json['intEksport'] as int? ?? 0,
      jenisPenjualan: json['JenisPenjualan'] as String? ?? "",
      cabang: json['Cabang'] as String? ?? "",
      customer: json['Customer'] as String? ?? "",
      sales: json['Sales'] as String? ?? "",
      valuta: json['Valuta'] as String? ?? "",
      gudang: json['Gudang'] as String? ?? "",
      area: json['Area'] as String? ?? "",
      kota: json['Kota'] as String? ?? "",
      barang: json['Barang'] as String? ?? "",
      satuan: json['Satuan'] as String? ?? "",
      satuan1: json['Satuan1'] as String? ?? "",
      satuanUnit: json['SatuanUnit'] as String? ?? "",
      total: json['total'] as int? ?? 0,
      qty: json['qty'] as int? ?? 0,
      konversisatuan2: json['konversi_satuan_2'] as int? ?? 0,
      konversisatuan3: json['konversi_satuan_3'] as int? ?? 0,
      decMultiplier1: (json['decMultiplier1'] as num?)?.toDouble() ?? 0,
      decMultiplier: (json['decMultiplier'] as num?)?.toDouble() ?? 0,
      decJumlah1: (json['decJumlah1'] as num?)?.toDouble() ?? 0,
      decJumlahUnit: (json['decJumlahUnit'] as num?)?.toDouble() ?? 0,
      decJumlah: (json['decJumlah'] as num?)?.toDouble() ?? 0,
      decTerkirim: (json['decTerkirim'] as num?)?.toDouble() ?? 0,
      decJumlahJadi: (json['decJumlahJadi'] as num?)?.toDouble() ?? 0,
      decKonversiJadi: (json['decKonversiJadi'] as num?)?.toDouble() ?? 0,
      decTerkirimJadi: (json['decTerkirimJadi'] as num?)?.toDouble() ?? 0,
      decTerprosesJadi: (json['decTerprosesJadi'] as num?)?.toDouble() ?? 0,
      decHarga: (json['decHarga'] as num?)?.toDouble() ?? 0,
      decDisc1: (json['decDisc1'] as num?)?.toDouble() ?? 0,
      decDisc2: (json['decDisc2'] as num?)?.toDouble() ?? 0,
      decDisc3: (json['decDisc3'] as num?)?.toDouble() ?? 0,
      decNetto: (json['decNetto'] as num?)?.toDouble() ?? 0,
      decBerat: (json['decBerat'] as num?)?.toDouble() ?? 0,
      decBeratbox: (json['decBeratbox'] as num?)?.toDouble() ?? 0,
      decKonversi2: (json['decKonversi2'] as num?)?.toDouble() ?? 0,
      decKonversi3: (json['decKonversi3'] as num?)?.toDouble() ?? 0,
      decTerbayar: (json['decTerbayar'] as num?)?.toDouble() ?? 0,
      decTotalIDR: (json['decTotalIDR'] as num?)?.toDouble() ?? 0,
      decTotalSupplier: (json['decTotalSupplier'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$OrderJualGetDataContentToJson(
    OrderJualGetDataContent instance) {
  final val = <String, dynamic>{
    'intNomor': instance.intNomor,
    'intNomorHeader': instance.intNomorHeader,
    'intNomorDetail': instance.intNomorDetail,
    'intNomorMBarang': instance.intNomorMBarang,
    'intNomorMBarangJadi': instance.intNomorMBarangJadi,
    'intNomorMSatuan': instance.intNomorMSatuan,
    'intNomorMSatuan1': instance.intNomorMSatuan1,
    'intNomorMSatuanUnit': instance.intNomorMSatuanUnit,
    'vcKode': instance.vcKode,
    'intTOP': instance.intTOP,
    'dtTanggal': instance.dtTanggal,
    'dtTanggalKirim': instance.dtTanggalKirim,
    'intJTHari': instance.intJTHari,
    'vcKeterangan': instance.vcKeterangan,
    'vcKeteranganFJ': instance.vcKeteranganFJ,
    'vcKeteranganKW': instance.vcKeteranganKW,
    'intJenisOJ': instance.intJenisOJ,
    'intJenis': instance.intJenis,
    'intGabungan': instance.intGabungan,
    'intNomorMCabang': instance.intNomorMCabang,
    'intNomorMCustomer': instance.intNomorMCustomer,
    'intNomorMSales': instance.intNomorMSales,
    'intNomorMJenisPenjualan': instance.intNomorMJenisPenjualan,
    'intNomorMValuta': instance.intNomorMValuta,
    'intNomorMProyek': instance.intNomorMProyek,
    'intBiaya': instance.intBiaya,
    'decSubTotal': instance.decSubTotal,
    'decKurs': instance.decKurs,
    'decDisc': instance.decDisc,
    'decDiscNominal': instance.decDiscNominal,
    'decPPN': instance.decPPN,
    'decPPNNominal': instance.decPPNNominal,
    'decTotal': instance.decTotal,
    'decTotalLama': instance.decTotalLama,
    'decDPP': instance.decDPP,
    'decTotalUMC': instance.decTotalUMC,
    'decSisa': instance.decSisa,
    'decTotalBiaya': instance.decTotalBiaya,
    'decTotalBiayaInternal': instance.decTotalBiayaInternal,
    'decTotalBiayaEstimasi': instance.decTotalBiayaEstimasi,
    'intApproved': instance.intApproved,
    'intApproveUserID': instance.intApproveUserID,
    'dtApproveTime': instance.dtApproveTime,
    'vcPenerima': instance.vcPenerima,
    'vcAlamat': instance.vcAlamat,
    'intNomorMKota': instance.intNomorMKota,
    'vcTelepon': instance.vcTelepon,
    'vcFax': instance.vcFax,
    'vcHP': instance.vcHP,
    'vcEmail': instance.vcEmail,
    'intNomorMUserApprovedBy': instance.intNomorMUserApprovedBy,
    'intNomorMGudang': instance.intNomorMGudang,
    'intDraft': instance.intDraft,
    'intPending': instance.intPending,
    'intSample': instance.intSample,
    'decUM1': instance.decUM1,
    'decUM2': instance.decUM2,
    'decUM3': instance.decUM3,
    'intValidasiUserID': instance.intValidasiUserID,
    'dtValidasiTime': instance.dtValidasiTime,
    'intUnValidasiUserID': instance.intUnValidasiUserID,
    'dtUnValidasiTime': instance.dtUnValidasiTime,
    'intNomorMArea': instance.intNomorMArea,
    'vcAlasanValidasi': instance.vcAlasanValidasi,
    'vcAlasanBatalValidasi': instance.vcAlasanBatalValidasi,
    'intEksport': instance.intEksport,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('JenisPenjualan', instance.jenisPenjualan);
  writeNotNull('Cabang', instance.cabang);
  writeNotNull('Customer', instance.customer);
  writeNotNull('Sales', instance.sales);
  writeNotNull('Valuta', instance.valuta);
  writeNotNull('Gudang', instance.gudang);
  writeNotNull('Area', instance.area);
  writeNotNull('Kota', instance.kota);
  val['total'] = instance.total;
  val['qty'] = instance.qty;
  writeNotNull('konversi_satuan_2', instance.konversisatuan2);
  writeNotNull('konversi_satuan_3', instance.konversisatuan3);
  writeNotNull('Barang', instance.barang);
  writeNotNull('Satuan', instance.satuan);
  writeNotNull('Satuan1', instance.satuan1);
  writeNotNull('SatuanUnit', instance.satuanUnit);
  val['decMultiplier1'] = instance.decMultiplier1;
  val['decMultiplier'] = instance.decMultiplier;
  val['decJumlah1'] = instance.decJumlah1;
  val['decJumlahUnit'] = instance.decJumlahUnit;
  val['decJumlah'] = instance.decJumlah;
  val['decTerkirim'] = instance.decTerkirim;
  val['decJumlahJadi'] = instance.decJumlahJadi;
  val['decKonversiJadi'] = instance.decKonversiJadi;
  val['decTerkirimJadi'] = instance.decTerkirimJadi;
  val['decTerprosesJadi'] = instance.decTerprosesJadi;
  val['decHarga'] = instance.decHarga;
  val['decDisc1'] = instance.decDisc1;
  val['decDisc2'] = instance.decDisc2;
  val['decDisc3'] = instance.decDisc3;
  val['decNetto'] = instance.decNetto;
  val['decBerat'] = instance.decBerat;
  val['decBeratbox'] = instance.decBeratbox;
  val['decKonversi2'] = instance.decKonversi2;
  val['decKonversi3'] = instance.decKonversi3;
  val['decTerbayar'] = instance.decTerbayar;
  val['decTotalIDR'] = instance.decTotalIDR;
  val['decTotalSupplier'] = instance.decTotalSupplier;
  return val;
}

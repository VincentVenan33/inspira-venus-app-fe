import 'package:json_annotation/json_annotation.dart';

part 'order_jual_get_data_dto.g.dart';

@JsonSerializable()
class OrderJualGetDataPayload {
  OrderJualGetDataPayload({
    required this.action,
    required this.filters,
    required this.search,
  });

  factory OrderJualGetDataPayload.fromJson(Map<String, dynamic> json) => _$OrderJualGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$OrderJualGetDataPayloadToJson(this);

  final String action;
  final OrderJualGetFilter filters;
  final List<OrderJualGetSearch> search;
}

@JsonSerializable()
class OrderJualGetFilter {
  OrderJualGetFilter({
    required this.limit,
    required this.page,
    this.startdate,
    this.enddate,
    this.sort,
    this.intNomor,
    this.orderby,
  });

  factory OrderJualGetFilter.fromJson(Map<String, dynamic> json) => _$OrderJualGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$OrderJualGetFilterToJson(this);

  final int limit;
  final int page;
  int? intNomor;
  @JsonKey(name: 'start_date')
  final String? startdate;
  @JsonKey(name: 'end_date')
  final String? enddate;
  final String? sort;
  @JsonKey(name: 'order_by')
  final String? orderby;
}

@JsonSerializable()
class OrderJualGetSearch {
  OrderJualGetSearch({
    this.term,
    this.key,
    this.query,
  });

  factory OrderJualGetSearch.fromJson(Map<String, dynamic> json) => _$OrderJualGetSearchFromJson(json);

  Map<String, dynamic> toJson() => _$OrderJualGetSearchToJson(this);

  final String? term;
  final String? key;
  final String? query;
}

@JsonSerializable()
class OrderJualGetDataResponse {
  OrderJualGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory OrderJualGetDataResponse.fromJson(Map<String, dynamic> json) => _$OrderJualGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderJualGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final OrderJualGetDataResult data;
}

@JsonSerializable()
class OrderJualGetDataResult {
  OrderJualGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory OrderJualGetDataResult.fromJson(Map<String, dynamic> json) => _$OrderJualGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$OrderJualGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<OrderJualGetDataContent> data;
}

@JsonSerializable()
class OrderJualGetDataContent {
  OrderJualGetDataContent({
    this.intNomor = 0,
    this.intNomorHeader = 0,
    this.intNomorDetail = 0,
    this.intNomorMBarang = 0,
    this.intNomorMBarangJadi = 0,
    this.intNomorMSatuan = 0,
    this.intNomorMSatuan1 = 0,
    this.intNomorMSatuanUnit = 0,
    this.vcKode = "",
    this.intTOP = 0,
    this.dtTanggal = "",
    this.dtTanggalKirim = "",
    this.intJTHari = 0,
    this.vcKeterangan = "",
    this.vcKeteranganFJ = "",
    this.vcKeteranganKW = "",
    this.intJenisOJ = 0,
    this.intJenis = 0,
    this.intGabungan = 0,
    this.intNomorMCabang = 0,
    this.intNomorMCustomer = 0,
    this.intNomorMSales = 0,
    this.intNomorMJenisPenjualan = 0,
    this.intNomorMValuta = 0,
    this.intNomorMProyek = 0,
    this.intBiaya = 0,
    this.decSubTotal = 0,
    this.decKurs = 0,
    this.decDisc = 0,
    this.decDiscNominal = 0,
    this.decPPN = 0,
    this.decPPNNominal = 0,
    this.decTotal = 0,
    this.decTotalLama = 0,
    this.decDPP = 0,
    this.decTotalUMC = 0,
    this.decSisa = 0,
    this.decTotalBiaya = 0,
    this.decTotalBiayaInternal = 0,
    this.decTotalBiayaEstimasi = 0,
    this.intApproved = 0,
    this.intApproveUserID = 0,
    this.dtApproveTime = "",
    this.vcPenerima = "",
    this.vcAlamat = "",
    this.intNomorMKota = 0,
    this.vcTelepon = "",
    this.vcFax = "",
    this.vcHP = "",
    this.vcEmail = "",
    this.intNomorMUserApprovedBy = 0,
    this.intNomorMGudang = 0,
    this.intDraft = 0,
    this.intPending = 0,
    this.intSample = 0,
    this.decUM1 = 0,
    this.decUM2 = 0,
    this.decUM3 = 0,
    this.intValidasiUserID = 0,
    this.dtValidasiTime = "",
    this.intUnValidasiUserID = 0,
    this.dtUnValidasiTime = "",
    this.intNomorMArea = 0,
    this.vcAlasanValidasi = "",
    this.vcAlasanBatalValidasi = "",
    this.intEksport = 0,
    this.jenisPenjualan = "",
    this.cabang = "",
    this.customer = "",
    this.sales = "",
    this.valuta = "",
    this.gudang = "",
    this.area = "",
    this.kota = "",
    this.barang = "",
    this.satuan = "",
    this.satuan1 = "",
    this.satuanUnit = "",
    this.total = 0,
    this.qty = 0,
    this.konversisatuan2 = 0,
    this.konversisatuan3 = 0,
    this.decMultiplier1 = 0,
    this.decMultiplier = 0,
    this.decJumlah1 = 0,
    this.decJumlahUnit = 0,
    this.decJumlah = 0,
    this.decTerkirim = 0,
    this.decJumlahJadi = 0,
    this.decKonversiJadi = 0,
    this.decTerkirimJadi = 0,
    this.decTerprosesJadi = 0,
    this.decHarga = 0,
    this.decDisc1 = 0,
    this.decDisc2 = 0,
    this.decDisc3 = 0,
    this.decNetto = 0,
    this.decBerat = 0,
    this.decBeratbox = 0,
    this.decKonversi2 = 0,
    this.decKonversi3 = 0,
    this.decTerbayar = 0,
    this.decTotalIDR = 0,
    this.decTotalSupplier = 0,
  });

  factory OrderJualGetDataContent.fromJson(Map<String, dynamic> json) => _$OrderJualGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$OrderJualGetDataContentToJson(this);

  final int intNomor;
  final int intNomorHeader;
  final int intNomorDetail;
  final int intNomorMBarang;
  final int intNomorMBarangJadi;
  final int intNomorMSatuan;
  final int intNomorMSatuan1;
  final int intNomorMSatuanUnit;
  final String vcKode;
  final int? intTOP;
  final String? dtTanggal;
  final String? dtTanggalKirim;
  final int? intJTHari;
  final String? vcKeterangan;
  final String? vcKeteranganFJ;
  final String? vcKeteranganKW;
  final int? intJenisOJ;
  final int? intJenis;
  final int? intGabungan;
  final int? intNomorMCabang;
  final int? intNomorMCustomer;
  final int? intNomorMSales;
  final int? intNomorMJenisPenjualan;
  final int? intNomorMValuta;
  final int? intNomorMProyek;
  final int? intBiaya;
  final double? decSubTotal;
  final double? decKurs;
  final double? decDisc;
  final double? decDiscNominal;
  final double? decPPN;
  final double? decPPNNominal;
  final double? decTotal;
  final double? decTotalLama;
  final double? decDPP;
  final double? decTotalUMC;
  final double? decSisa;
  final double? decTotalBiaya;
  final double? decTotalBiayaInternal;
  final double? decTotalBiayaEstimasi;
  final int? intApproved;
  final int? intApproveUserID;
  final String? dtApproveTime;
  final String? vcPenerima;
  final String? vcAlamat;
  final int? intNomorMKota;
  final String? vcTelepon;
  final String? vcFax;
  final String? vcHP;
  final String? vcEmail;
  final int? intNomorMUserApprovedBy;
  final int? intNomorMGudang;
  final int? intDraft;
  final int? intPending;
  final int? intSample;
  final double? decUM1;
  final double? decUM2;
  final double? decUM3;
  final int? intValidasiUserID;
  final String? dtValidasiTime;
  final int? intUnValidasiUserID;
  final String? dtUnValidasiTime;
  final int? intNomorMArea;
  final String? vcAlasanValidasi;
  final String? vcAlasanBatalValidasi;
  final int? intEksport;
  @JsonKey(name: 'JenisPenjualan', includeIfNull: false)
  final String? jenisPenjualan;
  @JsonKey(name: 'Cabang', includeIfNull: false)
  final String? cabang;
  @JsonKey(name: 'Customer', includeIfNull: false)
  final String? customer;
  @JsonKey(name: 'Sales', includeIfNull: false)
  final String? sales;
  @JsonKey(name: 'Valuta', includeIfNull: false)
  final String? valuta;
  @JsonKey(name: 'Gudang', includeIfNull: false)
  final String? gudang;
  @JsonKey(name: 'Area', includeIfNull: false)
  final String? area;
  @JsonKey(name: 'Kota', includeIfNull: false)
  final String? kota;
  final int? total;
  final int? qty;
  @JsonKey(name: 'konversi_satuan_2', includeIfNull: false)
  final int? konversisatuan2;
  @JsonKey(name: 'konversi_satuan_3', includeIfNull: false)
  final int? konversisatuan3;
  @JsonKey(name: 'Barang', includeIfNull: false)
  final String? barang;
  @JsonKey(name: 'Satuan', includeIfNull: false)
  final String? satuan;
  @JsonKey(name: 'Satuan1', includeIfNull: false)
  final String? satuan1;
  @JsonKey(name: 'SatuanUnit', includeIfNull: false)
  final String? satuanUnit;
  final double? decMultiplier1;
  final double? decMultiplier;
  final double? decJumlah1;
  final double? decJumlahUnit;
  final double? decJumlah;
  final double? decTerkirim;
  final double? decJumlahJadi;
  final double? decKonversiJadi;
  final double? decTerkirimJadi;
  final double? decTerprosesJadi;
  final double? decHarga;
  final double? decDisc1;
  final double? decDisc2;
  final double? decDisc3;
  final double? decNetto;
  final double? decBerat;
  final double? decBeratbox;
  final double? decKonversi2;
  final double? decKonversi3;
  final double? decTerbayar;
  final double? decTotalIDR;
  final double? decTotalSupplier;
}

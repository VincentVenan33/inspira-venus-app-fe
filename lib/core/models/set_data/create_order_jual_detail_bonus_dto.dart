import 'package:json_annotation/json_annotation.dart';

part 'create_order_jual_detail_bonus_dto.g.dart';

@JsonSerializable()
class CreateOrderJualDetailBonusPayload {
  CreateOrderJualDetailBonusPayload({
    required this.action,
    required this.requestData,
  });

  factory CreateOrderJualDetailBonusPayload.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderJualDetailBonusPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderJualDetailBonusPayloadToJson(this);

  final String action;
  final CreateOrderJualDetailBonusRequest requestData;
}

@JsonSerializable()
class CreateOrderJualDetailBonusRequest {
  CreateOrderJualDetailBonusRequest({
    required this.formatcode,
    required this.dtTanggal,
    required this.dtTanggalKirim,
    required this.intNomorMJenisPenjualan,
    required this.intNomorMValuta,
    required this.intNomorMGudang,
    required this.intNomorMCustomer,
    required this.intNomorMSales,
    required this.intNomorMArea,
    required this.intJenis,
    required this.intJTHari,
    required this.decKurs,
    required this.decUM1,
    required this.decUM2,
    required this.decUM3,
    required this.decTotalUMC,
    required this.decTotalBiaya,
    required this.decSubTotal,
    required this.decPPN,
    required this.decPPNNominal,
    required this.decDPP,
    required this.decSisa,
    required this.intEksport,
    required this.detail,
  });

  factory CreateOrderJualDetailBonusRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderJualDetailBonusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderJualDetailBonusRequestToJson(this);
  
  @JsonKey(name: 'format_code')
  final String? formatcode;
  final String dtTanggal;
  final String dtTanggalKirim;
  final int intNomorMJenisPenjualan;
  final int intNomorMValuta;
  final int intNomorMGudang;
  final int intNomorMCustomer;
  final int intNomorMSales;
  final int intNomorMArea;
  final int intJenis;
  final int decKurs;
  final int intJTHari;
  final int decUM1;
  final int decUM2;
  final int decUM3;
  final int decTotalUMC;
  final int decTotalBiaya;
  final int decSubTotal;
  final int decPPN;
  final int decPPNNominal;
  final int decDPP;
  final int decSisa;
  final int intEksport;
  final List<CreateDetailRequest> detail;
}

@JsonSerializable()
class CreateDetailRequest {
  CreateDetailRequest({
    required this.orderjualdetail,
    // this.orderjualbonusdetail,
  });

  factory CreateDetailRequest.fromJson(Map<String, dynamic> json) => _$CreateDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateDetailRequestToJson(this);

  @JsonKey(name: 'order_jual_detail')
  final List<CreateOrderJualDetailRequest> orderjualdetail;
  // @JsonKey(name: 'order_jual_bonus_detail')
  // final List<CreateOrderJualBonusDetailRequest>? orderjualbonusdetail;
}

// @JsonSerializable()
// class CreateOrderJualDetailContent {
//   CreateOrderJualDetailContent({
//     required this.orderjualdetailrequest,
//   });

//   factory CreateOrderJualDetailContent.fromJson(Map<String, dynamic> json) =>
//       _$CreateOrderJualDetailContentFromJson(json);

//   Map<String, dynamic> toJson() => _$CreateOrderJualDetailContentToJson(this);

//   final CreateOrderJualDetailRequest orderjualdetailrequest;
// }

@JsonSerializable()
class CreateOrderJualDetailRequest {
  CreateOrderJualDetailRequest({
    this.kodeBarang,
    this.barang,
    this.satuan1,
    required this.intNomorMBarang,
    required this.intNomorMSatuan1,
    required this.decJumlah1,
    required this.decNetto,
    required this.decDisc1,
    required this.decDisc2,
    required this.decDisc3,
    required this.decJumlahUnit,
    required this.dtTanggal,
    required this.decHarga,
    required this.decSubTotal,
    required this.decBerat,
  });

  factory CreateOrderJualDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderJualDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderJualDetailRequestToJson(this);

  @JsonKey(name: 'KodeBarang')
  final String? kodeBarang;
  @JsonKey(name: 'Barang')
  final String? barang;
  @JsonKey(name: 'Satuan1')
  final String? satuan1;
  final int? intNomorMBarang;
  final int? intNomorMSatuan1;
  final int? decJumlah1;
  final int? decNetto;
  final int? decDisc1;
  final int? decDisc2;
  final int? decDisc3;
  final int? decJumlahUnit;
  final String dtTanggal;
  final int? decHarga;
  final int decSubTotal;
  final int decBerat;
}

// @JsonSerializable()
// class CreateOrderJualBonusDetailContent {
//   CreateOrderJualBonusDetailContent({
//     required this.orderjualbonusdetailrequest,
//   });

//   factory CreateOrderJualBonusDetailContent.fromJson(Map<String, dynamic> json) =>
//       _$CreateOrderJualBonusDetailContentFromJson(json);

//   Map<String, dynamic> toJson() => _$CreateOrderJualBonusDetailContentToJson(this);

//   @JsonKey(name: 'order_jual_detail')
//   final CreateOrderJualBonusDetailRequest orderjualbonusdetailrequest;
// }

@JsonSerializable()
class CreateOrderJualBonusDetailRequest {
  CreateOrderJualBonusDetailRequest({
    required this.nomormhbarang,
    required this.nomormhsatuan,
    required this.qtyunit,
    required this.satuanunit,
    required this.qtyisi,
    required this.satuanisi,
    required this.konversisatuan,
    required this.selectedsatuan,
  });

  factory CreateOrderJualBonusDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderJualBonusDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderJualBonusDetailRequestToJson(this);

  final int nomormhbarang;
  final int nomormhsatuan;
  @JsonKey(name: 'qty_unit')
  final int qtyunit;
  @JsonKey(name: 'satuan_unit')
  final String satuanunit;
  @JsonKey(name: 'qty_isi')
  final int qtyisi;
  @JsonKey(name: 'satuan_isi')
  final String satuanisi;
  @JsonKey(name: 'konversi_satuan')
  final int konversisatuan;
  @JsonKey(name: 'selected_satuan')
  final int selectedsatuan;
}

@JsonSerializable()
class CreateOrderJualDetailResponse {
  CreateOrderJualDetailResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory CreateOrderJualDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderJualDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderJualDetailResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final SetOrderJualDetailDataContent data;
}

@JsonSerializable()
class SetOrderJualDetailDataContent {
  SetOrderJualDetailDataContent({
    required this.kode,
    required this.nomormhcustomer,
    required this.ppnprosentase,
    required this.statusppn,
    required this.tanggal,
    required this.dibuatoleh,
    required this.diubahpada,
    required this.dibuatpada,
    required this.id,
  });

  factory SetOrderJualDetailDataContent.fromJson(Map<String, dynamic> json) =>
      _$SetOrderJualDetailDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$SetOrderJualDetailDataContentToJson(this);

  final String kode;
  final String nomormhcustomer;
  @JsonKey(name: 'ppn_prosentase')
  final String ppnprosentase;
  @JsonKey(name: 'status_ppn')
  final int statusppn;
  final String tanggal;
  @JsonKey(name: 'dibuat_oleh')
  final int dibuatoleh;
  @JsonKey(name: 'diubah_pada')
  final String diubahpada;
  @JsonKey(name: 'dibuat_pada')
  final String dibuatpada;
  final int id;
}

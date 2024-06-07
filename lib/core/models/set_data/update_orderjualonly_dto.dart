import 'package:json_annotation/json_annotation.dart';

part 'update_orderjualonly_dto.g.dart';

@JsonSerializable()
class UpdateOrderJualOnlyPayload {
  UpdateOrderJualOnlyPayload({
    required this.action,
    required this.requestData,
  });

  factory UpdateOrderJualOnlyPayload.fromJson(Map<String, dynamic> json) => _$UpdateOrderJualOnlyPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualOnlyPayloadToJson(this);

  final String action;
  final UpdateOrderJualOnlyRequest requestData;
}

@JsonSerializable()
class UpdateOrderJualOnlyRequest {
  UpdateOrderJualOnlyRequest({
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
  });

  factory UpdateOrderJualOnlyRequest.fromJson(Map<String, dynamic> json) => _$UpdateOrderJualOnlyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualOnlyRequestToJson(this);

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
}

@JsonSerializable()
class UpdateOrderJualOnlyResponse {
  UpdateOrderJualOnlyResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory UpdateOrderJualOnlyResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderJualOnlyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualOnlyResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final int? data;
}

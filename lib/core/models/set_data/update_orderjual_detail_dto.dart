import 'package:json_annotation/json_annotation.dart';

part 'update_orderjual_detail_dto.g.dart';

@JsonSerializable()
class UpdateOrderJualDetailPayload {
  UpdateOrderJualDetailPayload({
    required this.action,
    required this.requestData,
  });

  factory UpdateOrderJualDetailPayload.fromJson(Map<String, dynamic> json) => _$UpdateOrderJualDetailPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualDetailPayloadToJson(this);

  final String action;
  final UpdateOrderJualDetailRequest requestData;
}

@JsonSerializable()
class UpdateOrderJualDetailRequest {
  UpdateOrderJualDetailRequest({required this.intNomorHeader,
    required this.intNomorDetail,
    required this.intNomorMSatuan1,
    required this.decJumlah1,
    required this.decNetto,
    required this.decDisc1,
    required this.decDisc2,
    required this.decDisc3,
    required this.decJumlahUnit,
    required this.decHarga,
    required this.decSubTotal,
    required this.decBerat,
  });

  factory UpdateOrderJualDetailRequest.fromJson(Map<String, dynamic> json) => _$UpdateOrderJualDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualDetailRequestToJson(this);

  final int? intNomorHeader;
  final int? intNomorDetail;
  final int? intNomorMSatuan1;
  final int? decJumlah1;
  final int? decNetto;
  final int? decDisc1;
  final int? decDisc2;
  final int? decDisc3;
  final int? decJumlahUnit;
  final int? decHarga;
  final int decSubTotal;
  final int decBerat;
}

@JsonSerializable()
class UpdateOrderJualDetailResponse {
  UpdateOrderJualDetailResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory UpdateOrderJualDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderJualDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderJualDetailResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final int? data;
}

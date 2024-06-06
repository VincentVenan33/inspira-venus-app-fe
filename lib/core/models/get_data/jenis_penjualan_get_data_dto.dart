import 'package:json_annotation/json_annotation.dart';

part 'jenis_penjualan_get_data_dto.g.dart';

@JsonSerializable()
class JenisPenjualanGetDataPayload {
  JenisPenjualanGetDataPayload({
    required this.action,
    required this.filters,
    this.search,
  });

  factory JenisPenjualanGetDataPayload.fromJson(Map<String, dynamic> json) =>
      _$JenisPenjualanGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$JenisPenjualanGetDataPayloadToJson(this);

  final String action;
  final JenisPenjualanGetFilter filters;
  final List<JenisPenjualanGetSearch>? search;
}

@JsonSerializable()
class JenisPenjualanGetFilter {
  JenisPenjualanGetFilter({
    required this.limit,
    this.page = 1,
    this.sort,
    this.orderby,
    this.nomor,
  });

  factory JenisPenjualanGetFilter.fromJson(Map<String, dynamic> json) => _$JenisPenjualanGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$JenisPenjualanGetFilterToJson(this);

  final int limit;
  final int page;
  final String? sort;
  @JsonKey(name: 'order_by')
  final String? orderby;
  final int? nomor;
}

@JsonSerializable()
class JenisPenjualanGetSearch {
  JenisPenjualanGetSearch({
    required this.term,
    this.key,
    this.query,
  });

  factory JenisPenjualanGetSearch.fromJson(Map<String, dynamic> json) => _$JenisPenjualanGetSearchFromJson(json);

  Map<String, dynamic> toJson() => _$JenisPenjualanGetSearchToJson(this);

  final String term;
  final String? key;
  final String? query;
}

@JsonSerializable()
class JenisPenjualanGetDataResponse {
  JenisPenjualanGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory JenisPenjualanGetDataResponse.fromJson(Map<String, dynamic> json) =>
      _$JenisPenjualanGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$JenisPenjualanGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final JenisPenjualanGetDataResult data;
}

@JsonSerializable()
class JenisPenjualanGetDataResult {
  JenisPenjualanGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory JenisPenjualanGetDataResult.fromJson(Map<String, dynamic> json) =>
      _$JenisPenjualanGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$JenisPenjualanGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<JenisPenjualanGetDataContent> data;
}

@JsonSerializable()
class JenisPenjualanGetDataContent {
  JenisPenjualanGetDataContent({
    required this.intNomor,
    required this.vcNama,
  });

  factory JenisPenjualanGetDataContent.fromJson(Map<String, dynamic> json) =>
      _$JenisPenjualanGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$JenisPenjualanGetDataContentToJson(this);

  final int intNomor;

  final String vcNama;
}

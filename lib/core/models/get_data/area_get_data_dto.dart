import 'package:json_annotation/json_annotation.dart';

part 'area_get_data_dto.g.dart';

@JsonSerializable()
class AreaGetDataPayload {
  AreaGetDataPayload({
    required this.action,
    required this.filters,
    this.search,
  });

  factory AreaGetDataPayload.fromJson(Map<String, dynamic> json) =>
      _$AreaGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$AreaGetDataPayloadToJson(this);

  final String action;
  final AreaGetFilter filters;
  final List<AreaGetSearch>? search;
}

@JsonSerializable()
class AreaGetFilter {
  AreaGetFilter({
    required this.limit,
    this.page = 1,
    this.sort,
    this.orderby,
    this.nomor,
  });

  factory AreaGetFilter.fromJson(Map<String, dynamic> json) => _$AreaGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$AreaGetFilterToJson(this);

  final int limit;
  final int page;
  final String? sort;
  @JsonKey(name: 'order_by')
  final String? orderby;
  final int? nomor;
}

@JsonSerializable()
class AreaGetSearch {
  AreaGetSearch({
    required this.term,
    this.key,
    this.query,
  });

  factory AreaGetSearch.fromJson(Map<String, dynamic> json) => _$AreaGetSearchFromJson(json);

  Map<String, dynamic> toJson() => _$AreaGetSearchToJson(this);

  final String term;
  final String? key;
  final String? query;
}

@JsonSerializable()
class AreaGetDataResponse {
  AreaGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory AreaGetDataResponse.fromJson(Map<String, dynamic> json) =>
      _$AreaGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AreaGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final AreaGetDataResult data;
}

@JsonSerializable()
class AreaGetDataResult {
  AreaGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory AreaGetDataResult.fromJson(Map<String, dynamic> json) =>
      _$AreaGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$AreaGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<AreaGetDataContent> data;
}

@JsonSerializable()
class AreaGetDataContent {
  AreaGetDataContent({
    required this.intNomor,
    required this.vcNama,
  });

  factory AreaGetDataContent.fromJson(Map<String, dynamic> json) =>
      _$AreaGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$AreaGetDataContentToJson(this);

  final int intNomor;

  final String vcNama;
}

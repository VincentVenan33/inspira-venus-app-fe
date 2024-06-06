import 'package:json_annotation/json_annotation.dart';

part 'valuta_get_data_dto.g.dart';

@JsonSerializable()
class ValutaGetDataPayload {
  ValutaGetDataPayload({
    required this.action,
    required this.filters,
    this.search,
  });

  factory ValutaGetDataPayload.fromJson(Map<String, dynamic> json) =>
      _$ValutaGetDataPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$ValutaGetDataPayloadToJson(this);

  final String action;
  final ValutaGetFilter filters;
  final List<ValutaGetSearch>? search;
}

@JsonSerializable()
class ValutaGetFilter {
  ValutaGetFilter({
    required this.limit,
    this.page = 1,
    this.sort,
    this.orderby,
    this.nomor,
  });

  factory ValutaGetFilter.fromJson(Map<String, dynamic> json) => _$ValutaGetFilterFromJson(json);

  Map<String, dynamic> toJson() => _$ValutaGetFilterToJson(this);

  final int limit;
  final int page;
  final String? sort;
  @JsonKey(name: 'order_by')
  final String? orderby;
  final int? nomor;
}

@JsonSerializable()
class ValutaGetSearch {
  ValutaGetSearch({
    required this.term,
    this.key,
    this.query,
  });

  factory ValutaGetSearch.fromJson(Map<String, dynamic> json) => _$ValutaGetSearchFromJson(json);

  Map<String, dynamic> toJson() => _$ValutaGetSearchToJson(this);

  final String term;
  final String? key;
  final String? query;
}

@JsonSerializable()
class ValutaGetDataResponse {
  ValutaGetDataResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory ValutaGetDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ValutaGetDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValutaGetDataResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final ValutaGetDataResult data;
}

@JsonSerializable()
class ValutaGetDataResult {
  ValutaGetDataResult({
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.totalrows,
    required this.data,
  });

  factory ValutaGetDataResult.fromJson(Map<String, dynamic> json) =>
      _$ValutaGetDataResultFromJson(json);

  Map<String, dynamic> toJson() => _$ValutaGetDataResultToJson(this);

  final String? draw;
  final int? recordsTotal;
  final int? recordsFiltered;
  @JsonKey(name: 'total_rows')
  final int? totalrows;
  final List<ValutaGetDataContent> data;
}

@JsonSerializable()
class ValutaGetDataContent {
  ValutaGetDataContent({
    required this.intNomor,
    required this.vcNama,
  });

  factory ValutaGetDataContent.fromJson(Map<String, dynamic> json) =>
      _$ValutaGetDataContentFromJson(json);

  Map<String, dynamic> toJson() => _$ValutaGetDataContentToJson(this);

  final int intNomor;

  final String vcNama;
}

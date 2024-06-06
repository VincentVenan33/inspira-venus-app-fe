import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:venus/core/apis/area_get_data_dto_api.dart';
import 'package:venus/core/models/get_data/area_get_data_dto.dart';
import 'package:venus/core/models/parsed_response.dart';
import 'package:venus/core/services/dio_service.dart';
import 'package:venus/core/utilities/error_utils.dart';

final areaGetDataDTOApi = Provider<AreaGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return AreaGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class AreaGetDataDTOService {
  AreaGetDataDTOService(
    Dio dio,
  ) : api = AreaGetDataDTOApi(
          dio,
        );
  final AreaGetDataDTOApi api;

  Future<Either<Failure, AreaGetDataResponse>> getData({
    required String action,
    required AreaGetFilter filters,
    required AreaGetSearch search,
  }) async {
    try {
      final payload = AreaGetDataPayload(
        action: action,
        filters: filters,
        search: [search],
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, AreaGetDataResponse>(
          AreaGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<AreaGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<AreaGetDataResponse>().handleError(e);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:venus/core/apis/total_get_data_dto_api.dart';
import 'package:venus/core/models/get_data/total_get_data_dto.dart';
import 'package:venus/core/models/parsed_response.dart';
import 'package:venus/core/services/dio_service.dart';
import 'package:venus/core/utilities/error_utils.dart';

final totalGetDataDTOApi = Provider<TotalGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return TotalGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class TotalGetDataDTOService {
  TotalGetDataDTOService(
    Dio dio,
  ) : api = TotalGetDataDTOApi(
          dio,
        );
  final TotalGetDataDTOApi api;

  Future<Either<Failure, TotalGetDataResponse>> getData({
    required String action,
  }) async {
    try {
      final payload = TotalGetDataPayload(
        action: action,
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, TotalGetDataResponse>(
          TotalGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<TotalGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<TotalGetDataResponse>().handleError(e);
    }
  }
}

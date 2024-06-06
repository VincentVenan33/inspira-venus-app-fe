import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:venus/core/apis/valuta_get_data_dto_api.dart';
import 'package:venus/core/models/get_data/valuta_get_data_dto.dart';
import 'package:venus/core/models/parsed_response.dart';
import 'package:venus/core/services/dio_service.dart';
import 'package:venus/core/utilities/error_utils.dart';

final valutaGetDataDTOApi = Provider<ValutaGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return ValutaGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class ValutaGetDataDTOService {
  ValutaGetDataDTOService(
    Dio dio,
  ) : api = ValutaGetDataDTOApi(
          dio,
        );
  final ValutaGetDataDTOApi api;

  Future<Either<Failure, ValutaGetDataResponse>> getData({
    required String action,
    required ValutaGetFilter filters,
    required ValutaGetSearch search,
  }) async {
    try {
      final payload = ValutaGetDataPayload(
        action: action,
        filters: filters,
        search: [search],
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, ValutaGetDataResponse>(
          ValutaGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<ValutaGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<ValutaGetDataResponse>().handleError(e);
    }
  }
}

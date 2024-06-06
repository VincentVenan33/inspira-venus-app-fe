import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:venus/core/apis/jenis_penjualan_get_data_dto_api.dart';
import 'package:venus/core/models/get_data/jenis_penjualan_get_data_dto.dart';
import 'package:venus/core/models/parsed_response.dart';
import 'package:venus/core/services/dio_service.dart';
import 'package:venus/core/utilities/error_utils.dart';

final jenisPenjualanGetDataDTOApi = Provider<JenisPenjualanGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return JenisPenjualanGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class JenisPenjualanGetDataDTOService {
  JenisPenjualanGetDataDTOService(
    Dio dio,
  ) : api = JenisPenjualanGetDataDTOApi(
          dio,
        );
  final JenisPenjualanGetDataDTOApi api;

  Future<Either<Failure, JenisPenjualanGetDataResponse>> getData({
    required String action,
    required JenisPenjualanGetFilter filters,
    required JenisPenjualanGetSearch search,
  }) async {
    try {
      final payload = JenisPenjualanGetDataPayload(
        action: action,
        filters: filters,
        search: [search],
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, JenisPenjualanGetDataResponse>(
          JenisPenjualanGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<JenisPenjualanGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<JenisPenjualanGetDataResponse>().handleError(e);
    }
  }
}

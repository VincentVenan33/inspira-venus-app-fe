import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:venus/core/apis/posisi_stok_get_data_dto_api.dart';
import 'package:venus/core/models/get_data/posisi_stok_get_data_dto.dart';
import 'package:venus/core/models/parsed_response.dart';
import 'package:venus/core/services/dio_service.dart';
import 'package:venus/core/utilities/error_utils.dart';

final posisiStokGetDataDTOApi = Provider<PosisiStokGetDataDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return PosisiStokGetDataDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class PosisiStokGetDataDTOService {
  PosisiStokGetDataDTOService(
    Dio dio,
  ) : api = PosisiStokGetDataDTOApi(
          dio,
        );
  final PosisiStokGetDataDTOApi api;

  Future<Either<Failure, PosisiStokGetDataResponse>> getData({
    required String action,
    required PosisiStokGetFilter filters,
  }) async {
    try {
      final payload = PosisiStokGetDataPayload(
        action: action,
        filters: filters,
      );
      final HttpResponse<dynamic> response = await api.getData(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, PosisiStokGetDataResponse>(
          PosisiStokGetDataResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<PosisiStokGetDataResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<PosisiStokGetDataResponse>().handleError(e);
    }
  }
}

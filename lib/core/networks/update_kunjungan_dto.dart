import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:venus/core/apis/update_kunjungan_dto_api.dart';
import 'package:venus/core/models/parsed_response.dart';
import 'package:venus/core/models/set_data/update_kunjungan_dto.dart';
import 'package:venus/core/services/dio_service.dart';
import 'package:venus/core/utilities/error_utils.dart';

final setUpdateKunjunganDTOApi = Provider<SetUpdateKunjunganDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetUpdateKunjunganDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetUpdateKunjunganDTOService {
  SetUpdateKunjunganDTOService(
    Dio dio,
  ) : api = UpdateKunjunganDTOApi(
          dio,
        );
  final UpdateKunjunganDTOApi api;

  Future<Either<Failure, UpdateKunjunganResponse>> setUpdateKunjungan({
    required final String action,
    required final double? latitude,
    required final double? longitude,
    required final String mode,
    required int nomor,
  }) async {
    try {
      final requestData = UpdateKunjunganRequest(
        latitude: latitude,
        longitude: longitude,
        mode: mode,
      );
      final payload = UpdateKunjunganPayload(
        action: action,
        requestData: requestData,
      );
      final HttpResponse<dynamic> response = await api.updateKunjungan(
        nomor,
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, UpdateKunjunganResponse>(
          UpdateKunjunganResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<UpdateKunjunganResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<UpdateKunjunganResponse>().handleError(e);
    }
  }
}

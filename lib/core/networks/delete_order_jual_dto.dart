import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:venus/core/apis/delete_order_jual_dto_api.dart';
import 'package:venus/core/models/delete_data/delete_order_jual_dto.dart';
import 'package:venus/core/models/parsed_response.dart';
import 'package:venus/core/services/dio_service.dart';
import 'package:venus/core/utilities/error_utils.dart';

final setDeleteOrderJualDTOApi = Provider<SetDeleteOrderJualDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetDeleteOrderJualDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetDeleteOrderJualDTOService {
  SetDeleteOrderJualDTOService(
    Dio dio,
  ) : api = DeleteOrderJualDTOApi(
          dio,
        );
  final DeleteOrderJualDTOApi api;

  Future<Either<Failure, DeleteOrderJualResponse>> setDeleteOrderJual({
    required final String action,
    required final int intDeleteUserID,
    required int intNomor,
  }) async {
    try {
      final payload = DeleteOrderJualPayload(
        action: action,
        intDeleteUserID: intDeleteUserID,
      );
      final HttpResponse<dynamic> response = await api.deleteOrderJual(
        intNomor,
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, DeleteOrderJualResponse>(
          DeleteOrderJualResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<DeleteOrderJualResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<DeleteOrderJualResponse>().handleError(e);
    }
  }
}

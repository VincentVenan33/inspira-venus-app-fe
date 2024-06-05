import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:venus/core/apis/delete_order_jual_detail_dto_api.dart';
import 'package:venus/core/models/delete_data/delete_order_jual_detail_dto.dart';
import 'package:venus/core/models/parsed_response.dart';
import 'package:venus/core/services/dio_service.dart';
import 'package:venus/core/utilities/error_utils.dart';

final setDeleteOrderJualDetailDTOApi = Provider<SetDeleteOrderJualDetailDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetDeleteOrderJualDetailDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetDeleteOrderJualDetailDTOService {
  SetDeleteOrderJualDetailDTOService(
    Dio dio,
  ) : api = DeleteOrderJualDetailDTOApi(
          dio,
        );
  final DeleteOrderJualDetailDTOApi api;

  Future<Either<Failure, DeleteOrderJualDetailResponse>> setDeleteOrderJualDetail({
    required final String action,
    required final int intDeleteUserID,
    required int nomor,
  }) async {
    try {
      final payload = DeleteOrderJualDetailPayload(
        action: action,
        intDeleteUserID: intDeleteUserID,
      );
      final HttpResponse<dynamic> response = await api.deleteOrderJualDetail(
        nomor,
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, DeleteOrderJualDetailResponse>(
          DeleteOrderJualDetailResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<DeleteOrderJualDetailResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<DeleteOrderJualDetailResponse>().handleError(e);
    }
  }
}

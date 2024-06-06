import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:venus/core/apis/update_orderjualdetail_dto_api.dart';
import 'package:venus/core/models/parsed_response.dart';
import 'package:venus/core/models/set_data/update_orderjual_detail_dto.dart';
import 'package:venus/core/services/dio_service.dart';
import 'package:venus/core/utilities/error_utils.dart';

final setUpdateOrderJualDetailDTOApi = Provider<SetUpdateOrderJualDetailDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetUpdateOrderJualDetailDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetUpdateOrderJualDetailDTOService {
  SetUpdateOrderJualDetailDTOService(
    Dio dio,
  ) : api = SetUpdateOrderJualDetailDTOApi(
          dio,
        );
  final SetUpdateOrderJualDetailDTOApi api;

  Future<Either<Failure, UpdateOrderJualDetailResponse>> seUpdatetOrderJual({
    required String action,
    required final int? intNomorHeader,
    required final int? intNomorDetail,
    required final int? intNomorMBarang,
    required final int? intNomorMSatuan1,
    required final int? decJumlah1,
    required final int? decHarga,
    required final int? decJumlahUnit,
    required final int? decDisc1,
    required final int? decDisc2,
    required final int? decDisc3,
    required final int? decNetto,
    required final int decBerat,
    required final int decSubTotal,
    required int nomor,
  }) async {
    try {
      final requestData = UpdateOrderJualDetailRequest(
        intNomorHeader: intNomorHeader,
        intNomorDetail: intNomorDetail,
        intNomorMBarang: intNomorMBarang,
        intNomorMSatuan1: intNomorMSatuan1,
        decJumlah1: decJumlah1,
        decHarga: decHarga,
        decJumlahUnit: decJumlahUnit,
        decDisc1: decDisc1,
        decDisc2: decDisc2,
        decDisc3: decDisc3,
        decNetto: decNetto,
        decSubTotal: decSubTotal,
        decBerat: decBerat,
      );
      final payload = UpdateOrderJualDetailPayload(
        action: action,
        requestData: requestData,
      );

      final HttpResponse<dynamic> response = await api.updateOrderJualDetail(
        nomor,
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, UpdateOrderJualDetailResponse>(
          UpdateOrderJualDetailResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<UpdateOrderJualDetailResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<UpdateOrderJualDetailResponse>().handleError(e);
    }
  }
}

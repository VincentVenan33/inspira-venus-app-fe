import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:venus/core/apis/create_order_jual_detail_dto_api.dart';
import 'package:venus/core/models/parsed_response.dart';
import 'package:venus/core/models/set_data/create_order_jual_detail_dto.dart';
import 'package:venus/core/services/dio_service.dart';
import 'package:venus/core/utilities/error_utils.dart';

final setOrderJualDetailDTOApi = Provider<SetOrderJualDetailDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetOrderJualDetailDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetOrderJualDetailDTOService {
  SetOrderJualDetailDTOService(
    Dio dio,
  ) : api = SetOrderJualDetailDTOApi(
          dio,
        );
  final SetOrderJualDetailDTOApi api;

  Future<Either<Failure, CreateOrderJualDetailResponse>> setOrderJualDetail({
    required final String action,
    required final String? formatcode,
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
    required final String dtTanggal,
    required final int decBerat,
    required final int decSubTotal,
  }) async {
    try {
      final requestData = CreateOrderJualDetailRequest(
        formatcode: formatcode,
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
        dtTanggal: dtTanggal,
      );
      final payload = CreateOrderJualDetailPayload(
        action: action,
        requestData: requestData,
      );
      final HttpResponse<dynamic> response = await api.createOrderJualDetail(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, CreateOrderJualDetailResponse>(
          CreateOrderJualDetailResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<CreateOrderJualDetailResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<CreateOrderJualDetailResponse>().handleError(e);
    }
  }
}

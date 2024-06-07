import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:venus/core/apis/create_order_jual_detail_bonus_dto_api.dart';
import 'package:venus/core/models/parsed_response.dart';
import 'package:venus/core/models/set_data/create_order_jual_detail_bonus_dto.dart';
import 'package:venus/core/services/dio_service.dart';
import 'package:venus/core/utilities/error_utils.dart';

final setOrderJualDetailBonusDTOApi = Provider<SetOrderJualDetailBonusDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetOrderJualDetailBonusDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetOrderJualDetailBonusDTOService {
  SetOrderJualDetailBonusDTOService(
    Dio dio,
  ) : api = SetOrderJualDetailBonusDTOApi(
          dio,
        );
  final SetOrderJualDetailBonusDTOApi api;

  Future<Either<Failure, CreateOrderJualDetailResponse>> setOrderJual({
    required String action,
    required final String formatcode,
    required final String dtTanggal,
    required final String dtTanggalKirim,
    required final int intNomorMJenisPenjualan,
    required final int intNomorMValuta,
    required final int intNomorMGudang,
    required final int intNomorMCustomer,
    required final int intNomorMSales,
    required final int intNomorMArea,
    required final int intJenis,
    required final int intJTHari,
    required final int decKurs,
    required final int decUM1,
    required final int decUM2,
    required final int decUM3,
    required final int decTotalUMC,
    required final int decTotalBiaya,
    required final int decSubTotal,
    required final int decPPN,
    required final int decPPNNominal,
    required final int decDPP,
    required final int decSisa,
    required final int intEksport,
    required final List<CreateOrderJualDetailRequest> detailitem,
  }) async {
    try {
      final detail = CreateDetailRequest(
        orderjualdetail: detailitem,
      );
      final requestData = CreateOrderJualDetailBonusRequest(
        formatcode: formatcode,
        dtTanggal: dtTanggal,
        dtTanggalKirim: dtTanggalKirim,
        intNomorMJenisPenjualan: intNomorMJenisPenjualan,
        intNomorMValuta: intNomorMValuta,
        intNomorMGudang: intNomorMGudang,
        intNomorMCustomer: intNomorMCustomer,
        intNomorMSales: intNomorMSales,
        intNomorMArea: intNomorMArea,
        intJenis: intJenis,
        decKurs: decKurs,
        intJTHari: intJTHari,
        decUM1: decUM1,
        decUM2: decUM2,
        decUM3: decUM3,
        decTotalUMC: decTotalUMC,
        decTotalBiaya: decTotalBiaya,
        decSubTotal: decSubTotal,
        decPPN: decPPN,
        decPPNNominal: decPPNNominal,
        decDPP: decDPP,
        decSisa: decSisa,
        intEksport: intEksport,
        detail: [detail],
      );
      final payload = CreateOrderJualDetailBonusPayload(
        action: action,
        requestData: requestData,
      );

      final HttpResponse<dynamic> response = await api.createOrderJual(
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

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';
import 'package:venus/core/apis/update_order_jual_only_dto_api.dart';
import 'package:venus/core/models/parsed_response.dart';
import 'package:venus/core/models/set_data/update_orderjualonly_dto.dart';
import 'package:venus/core/services/dio_service.dart';
import 'package:venus/core/utilities/error_utils.dart';

final setUpdateOrderJualOnlyDTOApi = Provider<SetUpdateOrderJualOnlyDTOService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return SetUpdateOrderJualOnlyDTOService(
    dio.getDio(domainType: DomainType.account),
  );
});

class SetUpdateOrderJualOnlyDTOService {
  SetUpdateOrderJualOnlyDTOService(
    Dio dio,
  ) : api = SetUpdateOrderJualOnlyDTOApi(
          dio,
        );
  final SetUpdateOrderJualOnlyDTOApi api;

  Future<Either<Failure, UpdateOrderJualOnlyResponse>> seUpdatetOrderJual({
    required String action,
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
    required int intNomor,
  }) async {
    try {
      final requestData = UpdateOrderJualOnlyRequest(
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
      );
      final payload = UpdateOrderJualOnlyPayload(
        action: action,
        requestData: requestData,
      );

      final HttpResponse<dynamic> response = await api.updateOrderJualOnly(
        intNomor,
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, UpdateOrderJualOnlyResponse>(
          UpdateOrderJualOnlyResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<UpdateOrderJualOnlyResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<UpdateOrderJualOnlyResponse>().handleError(e);
    }
  }
}

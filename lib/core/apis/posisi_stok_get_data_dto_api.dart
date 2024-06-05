import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:venus/core/models/get_data/posisi_stok_get_data_dto.dart';

part 'posisi_stok_get_data_dto_api.g.dart';

@RestApi()
abstract class PosisiStokGetDataDTOApi {
  factory PosisiStokGetDataDTOApi(Dio dio, {String baseUrl}) = _PosisiStokGetDataDTOApi;

  @POST('/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() PosisiStokGetDataPayload payload,
  );
}

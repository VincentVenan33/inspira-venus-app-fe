import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:venus/core/models/get_data/jenis_penjualan_get_data_dto.dart';

part 'jenis_penjualan_get_data_dto_api.g.dart';

@RestApi()
abstract class JenisPenjualanGetDataDTOApi {
  factory JenisPenjualanGetDataDTOApi(Dio dio, {String baseUrl}) = _JenisPenjualanGetDataDTOApi;

  @POST('/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() JenisPenjualanGetDataPayload payload,
  );
}

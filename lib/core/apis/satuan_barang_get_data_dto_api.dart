import 'package:dio/dio.dart';
import 'package:venus/core/models/get_data/satuan_barang_get_data_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'satuan_barang_get_data_dto_api.g.dart';

@RestApi()
abstract class SatuanBarangGetDataDTOApi {
  factory SatuanBarangGetDataDTOApi(Dio dio, {String baseUrl}) = _SatuanBarangGetDataDTOApi;

  @POST('/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() SatuanBarangGetDataPayload payload,
  );
}

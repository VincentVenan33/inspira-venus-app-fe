import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:venus/core/models/get_data/valuta_get_data_dto.dart';

part 'valuta_get_data_dto_api.g.dart';

@RestApi()
abstract class ValutaGetDataDTOApi {
  factory ValutaGetDataDTOApi(Dio dio, {String baseUrl}) = _ValutaGetDataDTOApi;

  @POST('/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() ValutaGetDataPayload payload,
  );
}

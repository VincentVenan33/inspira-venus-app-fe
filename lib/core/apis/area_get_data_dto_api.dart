import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:venus/core/models/get_data/area_get_data_dto.dart';

part 'area_get_data_dto_api.g.dart';

@RestApi()
abstract class AreaGetDataDTOApi {
  factory AreaGetDataDTOApi(Dio dio, {String baseUrl}) = _AreaGetDataDTOApi;

  @POST('/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() AreaGetDataPayload payload,
  );
}

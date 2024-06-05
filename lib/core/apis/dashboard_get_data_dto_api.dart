import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:venus/core/models/get_data/dashboard_get_data_dto.dart';

part 'dashboard_get_data_dto_api.g.dart';

@RestApi()
abstract class DashboardGetDataDTOApi {
  factory DashboardGetDataDTOApi(Dio dio, {String baseUrl}) = _DashboardGetDataDTOApi;

  @POST('/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() DashboardGetDataPayload payload,
  );
}

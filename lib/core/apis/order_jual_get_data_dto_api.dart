import 'package:dio/dio.dart';
import 'package:venus/core/models/get_data/order_jual_get_data_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'order_jual_get_data_dto_api.g.dart';

@RestApi()
abstract class OrderJualGetDataDTOApi {
  factory OrderJualGetDataDTOApi(Dio dio, {String baseUrl}) = _OrderJualGetDataDTOApi;

  @POST('/getData')
  Future<HttpResponse<dynamic>> getData(
    @Header('Accept') String accept,
    @Body() OrderJualGetDataPayload payload,
  );
}

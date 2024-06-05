import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:venus/core/models/set_data/create_order_jual_dto.dart';

part 'create_order_jual_dto_api.g.dart';

@RestApi()
abstract class SetOrderJualDTOApi {
  factory SetOrderJualDTOApi(Dio dio, {String baseUrl}) = _SetOrderJualDTOApi;

  @POST('/api/setData')
  Future<HttpResponse<dynamic>> createOrderJual(
    @Header('Accept') String accept,
    @Body() CreateOrderJualPayload payload,
  );
}

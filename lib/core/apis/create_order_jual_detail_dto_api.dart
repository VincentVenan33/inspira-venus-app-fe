import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:venus/core/models/set_data/create_order_jual_detail_dto.dart';

part 'create_order_jual_detail_dto_api.g.dart';

@RestApi()
abstract class SetOrderJualDetailDTOApi {
  factory SetOrderJualDetailDTOApi(Dio dio, {String baseUrl}) = _SetOrderJualDetailDTOApi;

  @POST('/setData')
  Future<HttpResponse<dynamic>> createOrderJualDetail(
    @Header('Accept') String accept,
    @Body() CreateOrderJualDetailPayload payload,
  );
}

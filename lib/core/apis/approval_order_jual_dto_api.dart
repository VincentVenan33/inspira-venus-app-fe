import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:venus/core/models/set_data/approval_order_jual_dto.dart';

part 'approval_order_jual_dto_api.g.dart';

@RestApi()
abstract class SetApprovalOrderJualDTOApi {
  factory SetApprovalOrderJualDTOApi(Dio dio, {String baseUrl}) = _SetApprovalOrderJualDTOApi;

  @PUT('updateData/{id}')
  Future<HttpResponse<dynamic>> approvalOrderJual(
    @Path('id') int intNomor,
    @Header('Accept') String accept,
    @Body() ApprovalOrderJualPayload payload,
  );
}

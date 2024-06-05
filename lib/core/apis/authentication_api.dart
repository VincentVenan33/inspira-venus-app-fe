import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:venus/core/models/authentication/login.dart';

part 'authentication_api.g.dart';

@RestApi()
abstract class AuthenticationApi {
  factory AuthenticationApi(Dio dio, {String baseUrl}) = _AuthenticationApi;

  @POST('/login')
  Future<HttpResponse<dynamic>> login(
    @Header('Accept') String accept,
    @Body() LoginRequest payload,
  );
}

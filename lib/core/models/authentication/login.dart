import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class LoginRequest {
  LoginRequest({
    required this.vcUserID,
    required this.vcMD5Password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  final String vcUserID;
  final String vcMD5Password;
}

@JsonSerializable()
class LoginResponse {
  LoginResponse({
    this.success,
    this.statusCode,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final LoginResponseData data;
}

@JsonSerializable()
class LoginResponseData {
  LoginResponseData({
    required this.token,
    required this.user,
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) => _$LoginResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);

  final String token;
  final UserData user;
}

@JsonSerializable()
class UserData {
  UserData({
    required this.intNomor,
    required this.intNomorMHUserGroup,
    required this.vcUserID,
    required this.vcPassword,
    required this.vcMD5UserID,
    required this.vcMD5Password,
    required this.intLevelPassword,
    required this.vcNama,
    required this.vcJabatan,
    required this.intCanSignApproval,
    required this.intNomorMCabang,
    required this.intInsertUserID,
    required this.dtInsertTime,
    required this.intUpdateUserID,
    required this.dtUpdateTime,
    required this.intDeleteUserID,
    required this.dtDeleteTime,
    required this.intStatus,
    required this.intPrinted,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  final int intNomor;
  final int intNomorMHUserGroup;
  final String vcUserID;
  final String vcPassword;
  final String vcMD5UserID;
  final String vcMD5Password;
  final int intLevelPassword;
  final String vcNama;
  final String vcJabatan;
  final int intCanSignApproval;
  final int intNomorMCabang;
  final int intInsertUserID;
  final String dtInsertTime;
  final int intUpdateUserID;
  final String dtUpdateTime;
  final int intDeleteUserID;
  final String dtDeleteTime;
  final int intStatus;
  final int intPrinted;
}

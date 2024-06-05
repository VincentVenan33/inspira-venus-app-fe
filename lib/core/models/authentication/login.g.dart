// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      vcUserID: json['vcUserID'] as String,
      vcMD5Password: json['vcMD5Password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'vcUserID': instance.vcUserID,
      'vcMD5Password': instance.vcMD5Password,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      data: LoginResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_code': instance.statusCode,
      'data': instance.data,
    };

LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) =>
    LoginResponseData(
      token: json['token'] as String,
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseDataToJson(LoginResponseData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      intNomor: json['intNomor'] as int,
      intNomorMHUserGroup: json['intNomorMHUserGroup'] as int,
      vcUserID: json['vcUserID'] as String,
      vcPassword: json['vcPassword'] as String,
      vcMD5UserID: json['vcMD5UserID'] as String,
      vcMD5Password: json['vcMD5Password'] as String,
      intLevelPassword: json['intLevelPassword'] as int,
      vcNama: json['vcNama'] as String,
      vcJabatan: json['vcJabatan'] as String,
      intCanSignApproval: json['intCanSignApproval'] as int,
      intNomorMCabang: json['intNomorMCabang'] as int,
      intInsertUserID: json['intInsertUserID'] as int,
      dtInsertTime: json['dtInsertTime'] as String,
      intUpdateUserID: json['intUpdateUserID'] as int,
      dtUpdateTime: json['dtUpdateTime'] as String,
      intDeleteUserID: json['intDeleteUserID'] as int,
      dtDeleteTime: json['dtDeleteTime'] as String,
      intStatus: json['intStatus'] as int,
      intPrinted: json['intPrinted'] as int,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'intNomor': instance.intNomor,
      'intNomorMHUserGroup': instance.intNomorMHUserGroup,
      'vcUserID': instance.vcUserID,
      'vcPassword': instance.vcPassword,
      'vcMD5UserID': instance.vcMD5UserID,
      'vcMD5Password': instance.vcMD5Password,
      'intLevelPassword': instance.intLevelPassword,
      'vcNama': instance.vcNama,
      'vcJabatan': instance.vcJabatan,
      'intCanSignApproval': instance.intCanSignApproval,
      'intNomorMCabang': instance.intNomorMCabang,
      'intInsertUserID': instance.intInsertUserID,
      'dtInsertTime': instance.dtInsertTime,
      'intUpdateUserID': instance.intUpdateUserID,
      'dtUpdateTime': instance.dtUpdateTime,
      'intDeleteUserID': instance.intDeleteUserID,
      'dtDeleteTime': instance.dtDeleteTime,
      'intStatus': instance.intStatus,
      'intPrinted': instance.intPrinted,
    };

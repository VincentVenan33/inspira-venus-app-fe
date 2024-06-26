import 'dart:async';
import 'dart:io';

import 'package:alice_lightweight/core/alice_core.dart';
import 'package:alice_lightweight/core/alice_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/subjects.dart';
import 'package:venus/core/app_constants/env.dart';
import 'package:venus/core/services/alice_service.dart';
import 'package:venus/core/services/authentication_service.dart';

final Provider<DioService> dioProvider = Provider<DioService>((ProviderRef<DioService> ref) {
  final AuthenticationService authService = ref.watch(authProvider);
  final AliceCore aliceCore = ref.watch(aliceCoreProvider);
  final DioServiceErrorHandler dioServiceErrorHandler = ref.watch(
    dioServiceErrorHandlerProvider,
  );

  return DioService(
    aliceCore: aliceCore,
    dioServiceErrorHandler: dioServiceErrorHandler,
    authenticationService: authService,
  );
});

final Provider<DioServiceErrorHandler> dioServiceErrorHandlerProvider =
    Provider<DioServiceErrorHandler>((ProviderRef<DioServiceErrorHandler> ref) {
  return DioServiceErrorHandler();
});

class DioServiceErrorHandler {
  final PublishSubject<DioError> _streamController = PublishSubject<DioError>();

  Stream<DioError> get _dioErrorStream => _streamController.stream;

  StreamSubscription<DioError>? _dioErrorSubscription;

  void close() {
    if (_counterLimitListener.length > _limitListener) {
      _counterLimitListener.removeLast();
      _dioErrorSubscription!.cancel();
    }
  }

  static const _limitListener = 1;
  final List<int> _counterLimitListener = [];

  void listen(Function(DioError dioError) callback) {
    if (_counterLimitListener.length < _limitListener) {
      _dioErrorSubscription = _dioErrorStream.listen(
        (DioError event) {
          callback(event);
        },
      );
      _counterLimitListener.add(1);
    }
  }

  set dioError(DioError dioError) {
    _streamController.add(dioError);
  }
}

enum DomainType {
  account,
  location,
  business,
  accounting,
  businessRelation,
  inventory,
  warehouse,
  purchasing,
  sales,
}

extension BaseUrlExt on DomainType {
  static Map<DomainType, String> baseUrls = <DomainType, String>{
    DomainType.account: EnvConstants.accountBaseUrl,
  };
  String get baseUrl => baseUrls[this]!;
}

class DioService {
  DioService({
    required AliceCore aliceCore,
    required DioServiceErrorHandler? dioServiceErrorHandler,
    required AuthenticationService authenticationService,
  })  : _dioServiceErrorHandler = dioServiceErrorHandler!,
        _aliceCore = aliceCore,
        _authenticationService = authenticationService;

  static CancelToken _cancelToken = CancelToken();
  static const int _timeOut = 10000;

  Map<String, int> retryCounter = <String, int>{};

  static void printLogs(dynamic args) {
    debugPrint(args);
  }

  final AliceCore _aliceCore;
  final DioServiceErrorHandler _dioServiceErrorHandler;
  // ignore: unused_field
  final AuthenticationService _authenticationService;

  Dio _makeBaseDio({
    DomainType domainType = DomainType.account,
  }) {
    return Dio()
      ..options.baseUrl = domainType.baseUrl
      ..options.connectTimeout = _timeOut
      ..interceptors.addAll(<Interceptor>[
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
          request: true,
          responseHeader: true,
        ),
        AliceDioInterceptor(_aliceCore),
      ]);
  }

  // ignore: unused_element
  dynamic _onDioError(
    DioError e,
    ErrorInterceptorHandler h,
  ) async {
    _dioServiceErrorHandler.dioError = e;
    // ErrorReportUtils.logDioErrorToCrashlytics(e);

    if (e.response != null) {
      return h.resolve(e.response!);
    }

    return h.next(e);
  }

  Dio getDio({
    DomainType domainType = DomainType.account,
  }) {
    final Dio baseDio = _makeBaseDio(
      domainType: domainType,
    );

    return baseDio
      ..options.headers.addAll(<String, dynamic>{
        HttpHeaders.contentTypeHeader: 'application/json',
      })
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (
            RequestOptions option,
            RequestInterceptorHandler handler,
          ) async {
            option.cancelToken = _cancelToken;

            return handler.next(option);
          },
          onError: (
            DioError error,
            ErrorInterceptorHandler handler,
          ) async {
            await _onDioWithStaticTokenError(
              error,
              handler,
            );
          },
        ),
      );
  }

  Dio getDioJwt({
    DomainType domainType = DomainType.account,
  }) {
    final Dio baseDio = _makeBaseDio(
      domainType: domainType,
    );

    return baseDio
      ..options.headers.addAll(<String, dynamic>{
        HttpHeaders.contentTypeHeader: 'application/json',
      })
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (
            RequestOptions option,
            RequestInterceptorHandler handler,
          ) async {
            //NOTE: belum di implementasi
            // final String? jwtToken = await _authenticationService.getJwtToken();
            const String jwtToken = '';

            option.cancelToken = _cancelToken;

            if (!option.headers.containsKey(HttpHeaders.authorizationHeader)) {
              option.headers[HttpHeaders.authorizationHeader] = 'Bearer $jwtToken';
            }

            return handler.next(option);
          },
        ),
      );
  }

  void cancelAllRequest() {
    _cancelToken.cancel('MANUAL CANCEL');
    _cancelToken = CancelToken();
  }

  dynamic _onDioWithStaticTokenError(
    DioError e,
    ErrorInterceptorHandler h, {
    void Function()? logout,
  }) async {
    _dioServiceErrorHandler.dioError = e;
    // ErrorReportUtils.logDioErrorToCrashlytics(e);

    if (e.response != null) {
      if (e.response?.statusCode == 401) {
        // final Response<dynamic> response = await _requestRetry(
        //   e.requestOptions,
        //   staticTokenKey,
        // );
        // return h.resolve(response);

        logout?.call();
      }

      logout?.call();

      return h.resolve(e.response!);
    }

    return h.next(e);
  }

  // Future<Response<dynamic>> _requestRetry(
  //   RequestOptions requestOptions,
  //   String staticTokenKey,
  // ) async {
  //   await initRemoteConfig;
  //   Response<dynamic> result;

  //   requestOptions.headers[HttpHeaders.authorizationHeader] =
  //       'Bearer ${credentialTokens.getTokenByKey(
  //     staticTokenKey,
  //   )}';
  //   retryCounter[requestOptions.path] =
  //       (retryCounter[requestOptions.path] ?? 0) + 1;

  //   result = await _retry(
  //     requestOptions,
  //     staticTokenKey,
  //   );

  //   return result;
  // }

  // Future<Response<dynamic>> _retry(
  //   RequestOptions requestOptions,
  //   String staticTokenKey,
  // ) async {
  //   final Options options = Options(
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );
  //   final Dio baseDio = _makeBaseDio();
  //   baseDio.options.baseUrl = requestOptions.baseUrl;
  //   baseDio.interceptors.add(
  //     InterceptorsWrapper(
  //       onRequest: (
  //         RequestOptions option,
  //         RequestInterceptorHandler handler,
  //       ) async {
  //         option.cancelToken = _cancelToken;

  //         return handler.next(option);
  //       },
  //       onError: (
  //         DioError error,
  //         ErrorInterceptorHandler handler,
  //       ) async {
  //         if ((retryCounter[requestOptions.path] ?? 0) < 3) {
  //           await _onDioWithStaticTokenError(
  //             error,
  //             handler,
  //             staticTokenKey,
  //           );
  //         }
  //       },
  //     ),
  //   );
  //   final Response<dynamic> response = await baseDio.request<dynamic>(
  //     requestOptions.path,
  //     data: requestOptions.data,
  //     queryParameters: requestOptions.queryParameters,
  //     options: options,
  //   );
  //   return response;
  // }
}

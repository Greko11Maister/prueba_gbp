import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AppInterceptors extends Interceptor {

  final GlobalKey <NavigatorState> navigatorKey =
  new GlobalKey <NavigatorState> ();

  @override
  Future<dynamic> onRequest(RequestOptions options) async {

    if (options.headers.containsKey("requirestoken")) {
      //remove the auxiliary header
      options.headers.remove("requirestoken");

     // final token = await authRepository.getToken();

     // options.headers.addAll({"Authorization": "Bearer $token"});

      return options;
    }
  }

  @override
  Future onError(DioError dioError) {

    String errorDescription = "";
    switch (dioError.type) {
      case DioErrorType.CANCEL:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        errorDescription =
        "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        errorDescription =
        "Received invalid status code: ${dioError.response.statusCode}";
        if(dioError.response.statusCode == 401) {
         // navigate to login page
        }
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = "Send timeout in connection with API server";
        break;
    }
    print("errorDescription:\t"+ errorDescription);
    dioError.error= errorDescription;
    return super.onError(dioError);
  }

  /*@override
  Future<dynamic> onResponse(Response options) async {
    if (options.headers.value("verifyToken") != null) {
      //if the header is present, then compare it with the Shared Prefs key
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var verifyToken = prefs.get("VerifyToken");

      // if the value is the same as the header, continue with the request
      if (options.headers.value("verifyToken") == verifyToken) {
        return options;
      }
    }

    return DioError(request: options.request, message: "User is no longer active");
  }*/
}
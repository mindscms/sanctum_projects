import 'package:dio/dio.dart';
import 'package:flutter_sanctum/providers/auth.dart';

Dio dio () {
  var dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api/',
      responseType: ResponseType.plain,
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json',
      }
    )
  );

  dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler){
        requestInterceptor(options);
        return handler.next(options); //continue
      }
  ));
  return dio;

}

dynamic requestInterceptor(RequestOptions options) async {
  if (options.headers.containsKey('auth')) {
    var token = await Auth().getToken();
    options.headers.addAll({ 'Authorization': 'Bearer $token' });
  }

}

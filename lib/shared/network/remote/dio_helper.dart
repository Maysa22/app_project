import 'package:dio/dio.dart';
class DioHelper
{
  static late Dio dio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://127.0.0.1:8000/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
    Map<String,dynamic>? query,
    String lang = 'ar',
    String? token,
  })async
  {
    dio.options.headers={
      'content_type':'application/json',
      'lang':lang,
      'Authorization': 'Bearer $token',
    };
    return await dio.get(url, queryParameters:query, );
  }

  static Future<Response?> postData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers={
      'content_type':'application/json',
      'lang':lang,
      'Authorization': 'Bearer $token',
    };
    print("%%%%% url : ${dio.options.baseUrl+url}");
    print("%%%%% token : ${dio.options.headers}");
    print("%%%%% data : $data");
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
  static Future<Response?> puttData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers={
      'content_type':'application/json',
      'lang':lang,
      'Authorization': 'Bearer $token',
    };
    print("%%%%% url : ${dio.options.baseUrl+url}");
    print("%%%%% token : ${dio.options.headers}");
    print("%%%%% data : $data");
    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }





  static Future<Response?> deleteData({
    required String url,
    Map<String,dynamic>? query,
    String lang = 'ar',
    String? token,
  })async
  {
    dio.options.headers={
      'content_type':'application/json',
      'lang':lang,
      'Authorization': 'Bearer $token',
    };
    return await dio.delete(url, queryParameters:query, );
  }



  static Future<Response?> postImage({
    required String url,
    required FormData data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers={
      'content_type':'application/json',
      'lang':lang,
      'Authorization': 'Bearer $token',
    };
    print("%%%%% url : ${dio.options.baseUrl+url}");
    print("%%%%% token : ${dio.options.headers}");
    print("%%%%% data : $data");
    return dio.post(
      url,
      data: data,
    );
  }
}
import 'package:dio/dio.dart';

abstract class HttpClient{
  Future<HttpResponse> get(String url, Options? options);
  
  Future<HttpResponse> post(
    String url, 
    dynamic data,
    {
      Options? option
    }
  );

  Future<HttpResponse> put(
    String url, 
    dynamic data,
    {
      Options? option
    }
  );

  Future<HttpResponse> delete(
    String url, 
    dynamic data,
    {
      Options? option
    }
  );

}

class HttpResponse {
  final dynamic data;
  final int? statusCode;
  
  HttpResponse({
    required this.data,
    required this.statusCode,
  });

}

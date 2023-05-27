import 'package:dio/dio.dart';
import 'package:lumiere/app/shared/core/http_client/http_client.dart';

class DioClientImplementation implements HttpClient{
  
  @override
  Future<HttpResponse> get(String url, dynamic options) async {

    final response = await Dio().get(
      url,
      options: options
    );
    return HttpResponse(data: response.data, statusCode: response.statusCode,);
  }

  @override
  Future<HttpResponse> post(String url, data, {dynamic option}) async{
    final response = await Dio().post(
      url,
      data: data,
      options: option
    );
    return HttpResponse(data: response.data, statusCode: response.statusCode,);
  }

  @override
  Future<HttpResponse> put(String url, data, {dynamic option}) async{
    final response = await Dio().put(
      url,
      data: data,
      options: option,
    );
    return HttpResponse(data: response.data, statusCode: response.statusCode,);
  }

  @override
  Future<HttpResponse> delete(String url, data, {dynamic option}) async{
    final response = await Dio().delete(
      url,
      data: data,
      options: option,
    );
    return HttpResponse(data: response.data, statusCode: response.statusCode,);
  }      

}

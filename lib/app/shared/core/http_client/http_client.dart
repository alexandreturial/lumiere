
abstract class HttpClient{
  Future<HttpResponse> get(String url, dynamic options);
  
  Future<HttpResponse> post(
    String url, 
    dynamic data,
    {
      dynamic option
    }
  );

  Future<HttpResponse> put(
    String url, 
    dynamic data,
    {
     dynamic option
    }
  );

  Future<HttpResponse> delete(
    String url, 
    dynamic data,
    {
     dynamic option
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

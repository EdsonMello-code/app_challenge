abstract class IHttpClient<HttpClient, Response> {
  final HttpClient client;

  IHttpClient(this.client);
  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  });
}

import 'package:challenge/app/features/home/externals/adapters/http_client/http_client.dart';
import 'package:dio/dio.dart';

class DioClient implements IHttpClient<Dio, Response> {
  @override
  final Dio client;

  DioClient({required this.client});

  @override
  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    client.options.baseUrl = 'https://forkify-api.herokuapp.com/api';

    final response = await client.get(
      endPoint,
      queryParameters: queryParameters,
    );
    return response;
  }
}

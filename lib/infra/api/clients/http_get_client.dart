import 'package:advanced_flutter/infra/types/json.dart';

abstract interface class HttpGetClient {
  Future get({required String url, Json? headers, Json? params, Json? queryString});
}

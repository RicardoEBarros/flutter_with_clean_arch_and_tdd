import 'package:http/http.dart';

import 'package:advanced_flutter/infra/api/adapters/http_adapter.dart';
import 'package:advanced_flutter/infra/api/clients/http_get_client.dart';

HttpGetClient makeHttpAdapter() {
  return HttpAdapter(client: Client());
}

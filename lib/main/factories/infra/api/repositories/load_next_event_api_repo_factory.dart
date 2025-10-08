import 'package:advanced_flutter/domain/repositories/load_next_event_repository.dart';
import 'package:advanced_flutter/infra/api/repositories/load_next_event_api_repo.dart';
import 'package:advanced_flutter/infra/mappers/next_event_mapper.dart';
import 'package:advanced_flutter/infra/mappers/next_event_player_mapper.dart';
import 'package:advanced_flutter/main/factories/infra/api/adapters/http_adapter_factory.dart';

LoadNextEventRepository makeLoadNextEventApiRepository() {
  const url = 'http://192.168.18.5:8080/api/groups/:groupId/next_event';
  return LoadNextEventApiRepository(
    httpClient: makeHttpAdapter(),
    url: url,
    mapper: NextEventMapper(playerMapper: NextEventPlayerMapper()),
  );
}

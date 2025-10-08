import 'package:advanced_flutter/domain/entities/errors.dart';
import 'package:advanced_flutter/domain/entities/next_event.dart';
import 'package:advanced_flutter/domain/repositories/load_next_event_repository.dart';
import 'package:advanced_flutter/infra/api/clients/http_get_client.dart';
import 'package:advanced_flutter/infra/mappers/mapper.dart';

// final class => ninguém poderá estender (extends) ou implementar (implements) essa classe
final class LoadNextEventApiRepository implements LoadNextEventRepository {
  final String url;
  final HttpGetClient httpClient;
  final DtoMapper<NextEvent> mapper;

  const LoadNextEventApiRepository({required this.httpClient, required this.url, required this.mapper});

  @override
  Future<NextEvent> loadNextEvent({required String groupId}) async {
    final json = await httpClient.get(url: url, params: {"groupId": groupId});
    if (json == null) throw UnexpectedError();
    return mapper.toDto(json);
  }
}

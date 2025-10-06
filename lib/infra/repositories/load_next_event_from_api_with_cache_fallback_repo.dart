import 'package:advanced_flutter/domain/entities/errors.dart';
import 'package:advanced_flutter/infra/cache/clients/cache_save_client.dart';
import 'package:advanced_flutter/infra/cache/mappers/next_event_mapper.dart';

import 'package:advanced_flutter/domain/entities/next_event.dart';

typedef LoadNextEventRepository = Future<NextEvent> Function({required String groupId});

final class LoadNextEventFromApiWithCacheFallbackRepository {
  final String key;
  final CacheSaveClient cacheClient;
  final LoadNextEventRepository loadNextEventFromApi;
  final LoadNextEventRepository loadNextEventFromCache;

  const LoadNextEventFromApiWithCacheFallbackRepository({
    required this.key,
    required this.cacheClient,
    required this.loadNextEventFromApi,
    required this.loadNextEventFromCache,
  });

  Future<NextEvent> loadNextEvent({required String groupId}) async {
    try {
      final event = await loadNextEventFromApi(groupId: groupId);
      final json = NextEventMapper().toJson(event);
      await cacheClient.save(key: '$key:$groupId', value: json);
      return event;
    } on SessionExpiredError {
      rethrow;
    } catch (e) {
      return loadNextEventFromCache(groupId: groupId);
    }
  }
}

import 'package:advanced_flutter/infra/cache/repositories/load_next_event_cache_repo.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:advanced_flutter/domain/entities/errors.dart';
import 'package:advanced_flutter/infra/cache/clients/cache_get_client.dart';

import '../../../mocks/fakes.dart';

final class CacheGetClientSpy implements CacheGetClient {
  String? key;
  int callsCount = 0;
  dynamic response;
  Error? error;

  @override
  Future<dynamic> get({required String key}) async {
    this.key = key;
    callsCount++;
    if (error != null) throw error!;
    return response;
  }
}

void main() {
  late String groupId;
  late String key;
  late CacheGetClientSpy cacheClient;
  late LoadNextEventCacheRepository sut;

  setUp(() {
    groupId = anyString();
    key = anyString();
    cacheClient = CacheGetClientSpy();
    cacheClient.response = {
      "groupName": "any_group_name",
      "date": DateTime(2024, 1, 1, 10, 30),
      "players": [
        {"id": "any_id_1", "name": "any_name_1", "isConfirmed": true},
        {
          "id": "any_id_2",
          "name": "any_name_2",
          "photo": "any_photo_2",
          "position": "any_position_2",
          "confirmationDate": DateTime(2024, 1, 1, 12, 30),
          "isConfirmed": false,
        },
      ],
    };
    sut = LoadNextEventCacheRepository(cacheClient: cacheClient, key: key);
  });

  test('should call CacheAdapter with correct input', () async {
    await sut.loadNextEvent(groupId: groupId);
    expect(cacheClient.key, '$key:$groupId');
    expect(cacheClient.callsCount, 1);
  });

  test('should return NexEvent on success', () async {
    final event = await sut.loadNextEvent(groupId: groupId);
    expect(event.groupName, 'any_group_name');
    expect(event.date, DateTime(2024, 1, 1, 10, 30));
    expect(event.players[0].id, 'any_id_1');
    expect(event.players[0].name, 'any_name_1');
    expect(event.players[0].isConfirmed, true);
    expect(event.players[1].id, 'any_id_2');
    expect(event.players[1].name, 'any_name_2');
    expect(event.players[1].position, 'any_position_2');
    expect(event.players[1].photo, 'any_photo_2');
    expect(event.players[1].confirmationDate, DateTime(2024, 1, 1, 12, 30));
    expect(event.players[1].isConfirmed, false);
  });

  test('should rethrow on error', () async {
    final error = Error();
    cacheClient.error = error;
    final future = sut.loadNextEvent(groupId: groupId);
    expect(future, throwsA(error));
  });

  test('should throw an Unexpected on null response', () async {
    cacheClient.response = null;
    final future = sut.loadNextEvent(groupId: groupId);
    expect(future, throwsA(const TypeMatcher<UnexpectedError>()));
  });
}

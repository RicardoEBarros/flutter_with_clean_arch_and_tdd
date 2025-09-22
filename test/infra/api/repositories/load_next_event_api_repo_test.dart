import 'package:advanced_flutter/domain/entities/domain_error.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:advanced_flutter/infra/api/repositories/load_next_event_api_repo.dart';

import 'package:faker/faker.dart';
import '../../../helpers/fakes.dart';
import '../clients/http_get_client_spy.dart';

void main() {
  late Faker fake;
  late String groupId;
  late String url;
  late HttpGetClientSpy httpClient;
  late LoadNextEventApiRepository sut;

  setUpAll(() {
    fake = Faker();
  });

  setUp(() {
    groupId = anyString();
    url = fake.internet.httpUrl();
    httpClient = HttpGetClientSpy();
    httpClient.response = {
      "groupName": "any_group_name",
      "date": "2024-08-30T10:30",
      "players": [
        {"id": "any_id_1", "name": "any_name_1", "isConfirmed": true},
        {"id": "any_id_2", "name": "any_name_2", "photo": "any_photo_2", "position": "any_position_2", "confirmationDate": "2024-08-29T11:00", "isConfirmed": false},
      ],
    };
    sut = LoadNextEventApiRepository(httpClient: httpClient, url: url);
  });

  test('should call HttpClient with correct input', () async {
    await sut.loadNextEvent(groupId: groupId);
    expect(httpClient.url, url);
    expect(httpClient.params, {"groupId": groupId});
    expect(httpClient.callsCount, 1);
  });

  test('should return NexEvent on success', () async {
    final event = await sut.loadNextEvent(groupId: groupId);
    expect(event.groupName, 'any_group_name');
    expect(event.date, DateTime(2024, 8, 30, 10, 30));
    expect(event.players[0].id, 'any_id_1');
    expect(event.players[0].name, 'any_name_1');
    expect(event.players[0].isConfirmed, true);
    expect(event.players[1].id, 'any_id_2');
    expect(event.players[1].name, 'any_name_2');
    expect(event.players[1].position, 'any_position_2');
    expect(event.players[1].photo, 'any_photo_2');
    expect(event.players[1].confirmationDate, DateTime(2024, 8, 29, 11, 00));
    expect(event.players[1].isConfirmed, false);
  });

  test('should rethrow on error', () async {
    final error = Error();
    httpClient.error = error;
    final future = sut.loadNextEvent(groupId: groupId);
    expect(future, throwsA(error));
  });

  test('should throw an Unexpected on null response', () async {
    httpClient.response = null;
    final future = sut.loadNextEvent(groupId: groupId);
    expect(future, throwsA(DomainError.unexpected));
  });
}

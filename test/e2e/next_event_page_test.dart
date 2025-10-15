import 'dart:io';
import 'package:advanced_flutter/infra/cache/adapters/cache_manager_adapter.dart';
import 'package:advanced_flutter/infra/cache/repositories/load_next_event_cache_repo.dart';
import 'package:advanced_flutter/infra/mappers/next_event_mapper.dart';
import 'package:advanced_flutter/infra/repositories/load_next_event_from_api_with_cache_fallback_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:advanced_flutter/infra/api/adapters/http_adapter.dart';
import 'package:advanced_flutter/infra/api/repositories/load_next_event_api_repo.dart';
import 'package:advanced_flutter/main/factories/infra/mappers/next_event_mapper_factory.dart';
import 'package:advanced_flutter/presentation/rx/next_event_rx_presenter.dart';
import 'package:advanced_flutter/ui/pages/next_event_page.dart';

import '../infra/api/mocks/client_spy.dart';
import '../infra/cache/mocks/cache_maganer_spy.dart';
import '../mocks/fakes.dart';

void main() {
  late String responseJson;
  late String key;
  late ClientSpy client;
  late CacheManagerSpy cacheManager;
  late HttpAdapter httpClient;
  late CacheManagerAdapter cacheClient;
  late LoadNextEventApiRepository apiRepo;
  late LoadNextEventCacheRepository cacheRepo;
  late LoadNextEventFromApiWithCacheFallbackRepository repo;
  late NextEventRxPresenter presenter;
  late MaterialApp sut;
  late NextEventMapper mapper;

  setUpAll(() async {
    final jsonFile = File('test/mocks/event.json');
    responseJson = await jsonFile.readAsString();
  });

  setUp(() {
    key = anyString();
    client = ClientSpy();
    httpClient = HttpAdapter(client: client);
    mapper = makeNextEventMapper();
    cacheManager = CacheManagerSpy();
    cacheClient = CacheManagerAdapter(client: cacheManager);
    apiRepo = LoadNextEventApiRepository(httpClient: httpClient, url: anyString(), mapper: mapper);
    cacheRepo = LoadNextEventCacheRepository(cacheClient: cacheClient, key: key, mapper: mapper);
    repo = LoadNextEventFromApiWithCacheFallbackRepository(
      key: key,
      cacheClient: cacheClient,
      loadNextEventFromApi: apiRepo.loadNextEvent,
      loadNextEventFromCache: cacheRepo.loadNextEvent,
      mapper: mapper,
    );
    presenter = NextEventRxPresenter(nextEventLoader: repo.loadNextEvent);
    sut = MaterialApp(
      home: NextEventPage(presenter: presenter, groupId: anyString()),
    );
  });

  testWidgets('should present api data', (tester) async {
    client.responseJson = responseJson;
    await tester.pumpWidget(sut);
    await tester.pump();
    await tester.ensureVisible(find.text('Cristiano Ronaldo', skipOffstage: false));
    await tester.pump();
    expect(find.text('Cristiano Ronaldo'), findsOneWidget);
    await tester.ensureVisible(find.text('Lionel Messi', skipOffstage: false));
    await tester.pump();
    expect(find.text('Lionel Messi'), findsOneWidget);
    await tester.ensureVisible(find.text('Claudio Gamarra', skipOffstage: false));
    await tester.pump();
    expect(find.text('Claudio Gamarra'), findsOneWidget);
  });

  testWidgets('should present cache data', (tester) async {
    client.simulateServerError();
    cacheManager.file.simulateResponse(responseJson);
    await tester.pumpWidget(sut);
    await tester.pump();
    await tester.ensureVisible(find.text('Cristiano Ronaldo', skipOffstage: false));
    await tester.pump();
    expect(find.text('Cristiano Ronaldo'), findsOneWidget);
    await tester.ensureVisible(find.text('Lionel Messi', skipOffstage: false));
    await tester.pump();
    expect(find.text('Lionel Messi'), findsOneWidget);
    await tester.ensureVisible(find.text('Claudio Gamarra', skipOffstage: false));
    await tester.pump();
    expect(find.text('Claudio Gamarra'), findsOneWidget);
  });
}

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:advanced_flutter/infra/api/adapters/http_adapter.dart';
import 'package:advanced_flutter/infra/api/repositories/load_next_event_api_repo.dart';
import 'package:advanced_flutter/main/factories/infra/mappers/next_event_mapper_factory.dart';
import 'package:advanced_flutter/presentation/rx/next_event_rx_presenter.dart';
import 'package:advanced_flutter/ui/pages/next_event_page.dart';

import '../infra/api/mocks/client_spy.dart';
import '../mocks/fakes.dart';

void main() {
  late String events;
  late ClientSpy client;
  late HttpAdapter httpClient;
  late LoadNextEventApiRepository apiRepo;
  late NextEventRxPresenter presenter;
  late MaterialApp sut;

  setUpAll(() async {
    final jsonFile = File('test/mocks/event.json');
    events = await jsonFile.readAsString();
  });

  setUp(() {
    client = ClientSpy();
    client.responseJson = events;
    httpClient = HttpAdapter(client: client);
    apiRepo = LoadNextEventApiRepository(httpClient: httpClient, url: anyString(), mapper: makeNextEventMapper());
    presenter = NextEventRxPresenter(nextEventLoader: apiRepo.loadNextEvent);
    sut = MaterialApp(
      home: NextEventPage(presenter: presenter, groupId: anyString()),
    );
  });

  testWidgets('should present next event page', (tester) async {
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

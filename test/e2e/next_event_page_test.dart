import 'dart:io';

import 'package:advanced_flutter/infra/api/adapters/http_adapter.dart';
import 'package:advanced_flutter/infra/api/repositories/load_next_event_api_repo.dart';
import 'package:advanced_flutter/presentation/rx/next_event_rx_presenter.dart';
import 'package:advanced_flutter/ui/pages/next_event_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../infra/api/mocks/client_spy.dart';
import '../mocks/fakes.dart';

void main() {
  late String events;

  setUpAll(() async {
    final jsonFile = File('test/mocks/event.json');
    events = await jsonFile.readAsString();
  });

  testWidgets('should present next event page', (tester) async {
    final client = ClientSpy();
    client.responseJson = events;
    final httpClient = HttpAdapter(client: client);
    final repo = LoadNextEventApiRepository(httpClient: httpClient, url: anyString());
    final presenter = NextEventRxPresenter(nextEventLoader: repo.loadNextEvent);
    final sut = MaterialApp(
      home: NextEventPage(presenter: presenter, groupId: anyString()),
    );
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

import 'dart:io';

import 'package:advanced_flutter/domain/usecases/next_event_loader.dart';
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
    final nextEventLoader = NextEventLoader(repo: repo);
    final presenter = NextEventRxPresenter(nextEventLoader: nextEventLoader.call);
    final sut = MaterialApp(
      home: NextEventPage(presenter: presenter, groupId: anyString()),
    );
    await tester.pumpWidget(sut);
    await tester.pump();
    expect(find.text('Cristiano Ronaldo'), findsOneWidget);
    expect(find.text('Lionel Messi'), findsOneWidget);
    expect(find.text('Claudio Taffarel'), findsOneWidget);
  });
}

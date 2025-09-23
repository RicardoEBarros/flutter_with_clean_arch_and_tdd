import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import 'package:advanced_flutter/ui/pages/next_event_page.dart';
import 'package:advanced_flutter/presentation/presenters/next_event_presenter.dart';

import 'package:flutter_test/flutter_test.dart';
import '../../helpers/fakes.dart';

final class NextEventPresenterSpy implements NextEventPresenter {
  String? groupId;
  int loadCallsCount = 0;
  var nextEventSubject = BehaviorSubject<NextEventViewModel>();

  @override
  Stream<NextEventViewModel> get nextEventStream => nextEventSubject.stream;

  void emitNextEvent([NextEventViewModel? viewModel]) {
    nextEventSubject.add(viewModel ?? const NextEventViewModel());
  }

  void emitNextEventWith({
    List<NextEventPlayerViewModel> goalkeepers = const [],
    List<NextEventPlayerViewModel> players = const [],
    List<NextEventPlayerViewModel> out = const [],
    List<NextEventPlayerViewModel> doubt = const [],
  }) {
    nextEventSubject.add(NextEventViewModel(goalkeepers: goalkeepers, players: players, out: out, doubt: doubt));
  }

  void emitError() {
    nextEventSubject.addError(Error());
  }

  @override
  void loadNextEvent({required String groupId}) {
    this.groupId = groupId;
    loadCallsCount++;
  }
}

void main() {
  late NextEventPresenterSpy presenter;
  late String groupId;
  late Widget sut;

  setUp(() {
    presenter = NextEventPresenterSpy();
    groupId = anyString();
    sut = MaterialApp(
      home: NextEventPage(presenter: presenter, groupId: groupId),
    );
  });

  testWidgets('should load event data on page init', (tester) async {
    await tester.pumpWidget(sut);
    expect(presenter.loadCallsCount, 1);
    expect(presenter.groupId, groupId);
  });

  testWidgets('should present spinner while data is loading', (tester) async {
    await tester.pumpWidget(sut);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should hide spinner on load success', (tester) async {
    await tester.pumpWidget(sut);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    presenter.emitNextEvent();
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('should hide spinner on load error', (tester) async {
    await tester.pumpWidget(sut);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    presenter.emitError();
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('should present goalkeepers section', (tester) async {
    await tester.pumpWidget(sut);
    presenter.emitNextEventWith(
      goalkeepers: const [
        NextEventPlayerViewModel(name: 'Ricardo'),
        NextEventPlayerViewModel(name: 'Rafael'),
        NextEventPlayerViewModel(name: 'Pedro'),
      ],
    );
    await tester.pump();
    expect(find.text('DENTRO - GOLEIROS'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('Ricardo'), findsOneWidget);
    expect(find.text('Rafael'), findsOneWidget);
    expect(find.text('Pedro'), findsOneWidget);
  });

  testWidgets('should present players section', (tester) async {
    await tester.pumpWidget(sut);
    presenter.emitNextEventWith(
      players: const [
        NextEventPlayerViewModel(name: 'Ricardo'),
        NextEventPlayerViewModel(name: 'Rafael'),
        NextEventPlayerViewModel(name: 'Pedro'),
      ],
    );
    await tester.pump();
    expect(find.text('DENTRO - JOGADORES'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('Ricardo'), findsOneWidget);
    expect(find.text('Rafael'), findsOneWidget);
    expect(find.text('Pedro'), findsOneWidget);
  });

  testWidgets('should out out section', (tester) async {
    await tester.pumpWidget(sut);
    presenter.emitNextEventWith(
      out: const [
        NextEventPlayerViewModel(name: 'Ricardo'),
        NextEventPlayerViewModel(name: 'Rafael'),
        NextEventPlayerViewModel(name: 'Pedro'),
      ],
    );
    await tester.pump();
    expect(find.text('FORA'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('Ricardo'), findsOneWidget);
    expect(find.text('Rafael'), findsOneWidget);
    expect(find.text('Pedro'), findsOneWidget);
  });

  testWidgets('should out doubt section', (tester) async {
    await tester.pumpWidget(sut);
    presenter.emitNextEventWith(
      doubt: const [
        NextEventPlayerViewModel(name: 'Ricardo'),
        NextEventPlayerViewModel(name: 'Rafael'),
        NextEventPlayerViewModel(name: 'Pedro'),
      ],
    );
    await tester.pump();
    expect(find.text('DÚVIDA'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('Ricardo'), findsOneWidget);
    expect(find.text('Rafael'), findsOneWidget);
    expect(find.text('Pedro'), findsOneWidget);
  });

  testWidgets('should hide goalkeepers section', (tester) async {
    await tester.pumpWidget(sut);
    presenter.emitNextEvent();
    await tester.pump();
    expect(find.text('DENTRO - GOLEIROS'), findsNothing);
    expect(find.text('DENTRO - JOGADORES'), findsNothing);
    expect(find.text('FORA'), findsNothing);
    expect(find.text('DÚVIDA'), findsNothing);
  });
}

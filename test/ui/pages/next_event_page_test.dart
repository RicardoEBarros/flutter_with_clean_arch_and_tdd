import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';

final class NextEventPage extends StatefulWidget {
  final String groupId;
  final NextEventPresenter presenter;
  const NextEventPage({required this.presenter, required this.groupId, super.key});

  @override
  State<NextEventPage> createState() => _NextEventPageState();
}

class _NextEventPageState extends State<NextEventPage> {
  @override
  void initState() {
    widget.presenter.loadNextEvent(groupId: widget.groupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

abstract class NextEventPresenter {
  void loadNextEvent({required String groupId});
}

final class NextEventPresenterSpy implements NextEventPresenter {
  String? groupId;
  int loadCallsCount = 0;

  @override
  void loadNextEvent({required String groupId}) {
    this.groupId = groupId;
    loadCallsCount++;
  }
}

void main() {
  testWidgets('should load event data on page init', (tester) async {
    final presenter = NextEventPresenterSpy();
    final groupId = anyString();
    final sut = MaterialApp(
      home: NextEventPage(presenter: presenter, groupId: groupId),
    );
    await tester.pumpWidget(sut);
    expect(presenter.loadCallsCount, 1);
    expect(presenter.groupId, groupId);
  });
}

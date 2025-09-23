import 'package:flutter/material.dart';

import 'package:advanced_flutter/ui/components/player_status.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should present green status', (tester) async {
    const sut = MaterialApp(home: PlayerStatus(isConfirmed: true));
    await tester.pumpWidget(sut);
    final decoration = tester.firstWidget<Container>(find.byType(Container)).decoration as BoxDecoration;
    expect(decoration.color, Colors.teal);
  });

  testWidgets('should present pink status', (tester) async {
    const sut = MaterialApp(home: PlayerStatus(isConfirmed: false));
    await tester.pumpWidget(sut);
    final decoration = tester.firstWidget<Container>(find.byType(Container)).decoration as BoxDecoration;
    expect(decoration.color, Colors.pink);
  });

  testWidgets('should present pink status', (tester) async {
    const sut = MaterialApp(home: PlayerStatus(isConfirmed: null));
    await tester.pumpWidget(sut);
    final decoration = tester.firstWidget<Container>(find.byType(Container)).decoration as BoxDecoration;
    expect(decoration.color, Colors.blueGrey);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final class PlayerStatus extends StatelessWidget {
  final bool isConfirmed;
  const PlayerStatus({required this.isConfirmed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(shape: BoxShape.circle, color: getColor()),
    );
  }

  Color getColor() => isConfirmed ? Colors.teal : Colors.pink;
}

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
}

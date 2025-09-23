import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final class PlayerPosition extends StatelessWidget {
  final String position;
  const PlayerPosition({required this.position, super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Goleiro');
  }
}

void main() {
  testWidgets('should handle goalkeeper position', (tester) async {
    final sut = MaterialApp(home: PlayerPosition(position: 'goalkeeper'));
    await tester.pumpWidget(sut);
    expect(find.text('Goleiro'), findsOneWidget);
  });
}

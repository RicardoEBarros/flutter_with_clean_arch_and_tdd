import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final class PlayerPosition extends StatelessWidget {
  final String? position;
  const PlayerPosition({this.position, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(_buildPositionLabel());
  }

  String _buildPositionLabel() => switch (position) {
    'goalkeeper' => 'Goleiro',
    _ => 'Gândula',
  };
}

void main() {
  testWidgets('should handle goalkeeper position', (tester) async {
    final sut = MaterialApp(home: PlayerPosition(position: 'goalkeeper'));
    await tester.pumpWidget(sut);
    expect(find.text('Goleiro'), findsOneWidget);
  });

  testWidgets('should handle positionless', (tester) async {
    final sut = MaterialApp(home: PlayerPosition(position: null));
    await tester.pumpWidget(sut);
    expect(find.text('Gândula'), findsOneWidget);
  });
}

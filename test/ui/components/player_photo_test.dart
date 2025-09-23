import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final class PlayerPhoto extends StatelessWidget {
  final String initials;
  final String? photo;
  const PlayerPhoto({required this.initials, this.photo, super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(child: Text('RI'));
  }
}

void main() {
  testWidgets('should present initials when there is no photo', (tester) async {
    final sut = MaterialApp(home: PlayerPhoto(initials: 'RI', photo: null));
    await tester.pumpWidget(sut);
    expect(find.text('RI'), findsOneWidget);
  });
}

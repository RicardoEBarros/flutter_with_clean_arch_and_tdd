import 'package:flutter/material.dart';

import 'package:advanced_flutter/ui/components/player_photo.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('should present initials when there is no photo', (tester) async {
    final sut = MaterialApp(home: PlayerPhoto(initials: 'RI', photo: null));
    await tester.pumpWidget(sut);
    expect(find.text('RI'), findsOneWidget);
  });

  testWidgets('should hide initials when there is photo', (tester) async {
    mockNetworkImagesFor(() async {
      final sut = MaterialApp(
        home: PlayerPhoto(initials: 'RI', photo: 'http://any-url.com'),
      );
      await tester.pumpWidget(sut);
      expect(find.text('RI'), findsNothing);
    });
  });
}

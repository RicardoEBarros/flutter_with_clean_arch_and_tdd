import 'package:flutter/material.dart';

final class PlayerPosition extends StatelessWidget {
  final String? position;
  const PlayerPosition({this.position, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(_buildPositionLabel());
  }

  String _buildPositionLabel() => switch (position) {
    'goalkeeper' => 'Goleiro',
    'defender' => 'Zagueiro',
    'midfielder' => 'Meia',
    'forward' => 'Atacante',
    _ => 'Gândula',
  };
}

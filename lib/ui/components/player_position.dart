import 'package:flutter/material.dart';

final class PlayerPosition extends StatelessWidget {
  final String? position;
  const PlayerPosition({this.position, super.key});

  String _buildPositionLabel() => switch (position) {
    'goalkeeper' => 'Goleiro',
    'defender' => 'Zagueiro',
    'midfielder' => 'Meia',
    'forward' => 'Atacante',
    _ => 'Gândula',
  };

  @override
  Widget build(BuildContext context) {
    return Text(
      _buildPositionLabel(),
      style: Theme.of(context).textTheme.labelMedium!.apply(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7)),
    );
  }
}

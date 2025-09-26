import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
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
      style: context.textStyles.labelMedium.apply(color: context.colors.scheme.primary.withValues(alpha: 0.7)),
    );
  }
}

import 'package:flutter_test/flutter_test.dart';

class NextEventPlayer {
  final String id;
  final String name;
  late final String initials;
  final String? photo;
  final String? position;
  final bool isConfirmed;
  final DateTime? confirmationDate;

  NextEventPlayer({
    required this.id,
    required this.name,
    required this.isConfirmed,
    this.photo,
    this.position,
    this.confirmationDate,
  }) {
    initials = _getInitials();
  }

  String _getInitials() {
    final names = name.toUpperCase().split(' ');
    final firstChar = names.first[0];
    final lastChar = names.last[names.length == 1 ? 1 : 0];
    return '$firstChar$lastChar';
  }
}

void main() {
  String initialsOf(String name) {
    return NextEventPlayer(id: '', name: name, isConfirmed: true).initials;
  }

  test('should return the fist letter of the first and last names', () {
    expect(initialsOf('Ricardo Barros'), equals('RB'));
    expect(initialsOf('Pedro Alonso'), equals('PA'));
    expect(initialsOf('Ingrid Mota da Silva'), equals('IS'));
  });

  test('should return the first letters of the first name', () {
    expect(initialsOf("Ricardo"), equals('RI'));
  });

  test('should convert to uppercase', () {
    expect(initialsOf("ricardo barros"), equals('RB'));
    expect(initialsOf("ricardo"), equals('RI'));
  });
}

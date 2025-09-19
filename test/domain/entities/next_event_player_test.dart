import 'package:flutter_test/flutter_test.dart';

class NextEventPlayer {
  final String id;
  final String name;
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
  });

  String getInitials() {
    final names = name.split(' ');
    final firstChar = names.first[0];
    final lastChar = names.last[0];
    return '$firstChar$lastChar';
  }
}

void main() {
  NextEventPlayer makeSut(String name) {
    return NextEventPlayer(id: '', name: name, isConfirmed: true);
  }

  test('should return the fist letter of the first and last names', () {
    final sut = makeSut('Ricardo Barros');
    expect(sut.getInitials(), 'RB');

    final sut2 = makeSut('Pedro Alonso');
    expect(sut2.getInitials(), 'PA');

    final sut3 = makeSut('Ingrid Mota da Silva');
    expect(sut3.getInitials(), 'IS');
  });
}

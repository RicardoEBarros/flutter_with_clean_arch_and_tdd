import 'package:advanced_flutter/domain/entities/next_event_player.dart';
import 'package:flutter_test/flutter_test.dart';

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
    expect(initialsOf('Ricardo'), equals('RI'));
    expect(initialsOf('R'), equals('R'));
  });

  test('should return "-" when name is empty', () {
    expect(initialsOf(''), equals('-'));
  });

  test('should convert to uppercase', () {
    expect(initialsOf('ricardo barros'), equals('RB'));
    expect(initialsOf('ricardo'), equals('RI'));
    expect(initialsOf('r'), equals('R'));
  });

  test('should ignore extra whitespaces', () {
    expect(initialsOf('Ricardo Barros '), equals('RB'));
    expect(initialsOf(' Ricardo Barros'), equals('RB'));
    expect(initialsOf('Ricardo  Barros'), equals('RB'));
    expect(initialsOf(' Ricardo  Barros '), equals('RB'));
    expect(initialsOf(' Ricardo '), equals('RI'));
    expect(initialsOf(' R '), equals('R'));
    expect(initialsOf(' '), equals('-'));
    expect(initialsOf('  '), equals('-'));
  });
}

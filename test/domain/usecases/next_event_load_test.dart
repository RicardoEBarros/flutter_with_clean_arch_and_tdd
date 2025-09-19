import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';

class NextEventLoader {
  final LoadNextEventRepository repo;

  NextEventLoader({required this.repo});

  Future<void> call({required String groupId}) async {
    await repo.loadNextEvent(groupId: groupId);
  }
}

class LoadNextEventRepository {
  String? groupId;
  int callsCount = 0;

  Future<void> loadNextEvent({required String groupId}) async {
    this.groupId = groupId;
    callsCount++;
  }
}

void main() {
  final Faker faker = Faker();

  test('should load event data from a repository', () async {
    final groupId = faker.randomGenerator.integer(5000).toString();
    final repo = LoadNextEventRepository();
    final sut = NextEventLoader(repo: repo);
    await sut(groupId: groupId);
    expect(repo.groupId, groupId);
    expect(repo.callsCount, 1);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';

class NextEventLoader {
  final LoadNextEventRepository repo;

  NextEventLoader({required this.repo});

  Future<void> call({required String groupId}) async {
    await repo.loadNextEvent(groupId: groupId);
  }
}

abstract class LoadNextEventRepository {
  Future<void> loadNextEvent({required String groupId});
}

class LoadNextEventMockRepository implements LoadNextEventRepository {
  String? groupId;
  int callsCount = 0;

  @override
  Future<void> loadNextEvent({required String groupId}) async {
    this.groupId = groupId;
    callsCount++;
  }
}

void main() {
  late Faker faker;
  late String groupId;
  late LoadNextEventMockRepository repo;
  late NextEventLoader sut;

  setUpAll(() {
    faker = Faker();
  });

  setUp(() {
    groupId = faker.randomGenerator.integer(5000).toString();
    repo = LoadNextEventMockRepository();
    sut = NextEventLoader(repo: repo);
  });

  test('should load event data from a repository', () async {
    await sut(groupId: groupId);
    expect(repo.groupId, groupId);
    expect(repo.callsCount, 1);
  });
}

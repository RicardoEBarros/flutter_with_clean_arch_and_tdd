import 'package:advanced_flutter/domain/entities/next_event_player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';

class NextEvent {
  final String groupName;
  final DateTime date;
  final List<NextEventPlayer> players;

  NextEvent({
    required this.groupName,
    required this.date,
    required this.players,
  });
}

class NextEventLoader {
  final LoadNextEventRepository repo;

  NextEventLoader({required this.repo});

  Future<NextEvent> call({required String groupId}) async {
    return repo.loadNextEvent(groupId: groupId);
  }
}

abstract class LoadNextEventRepository {
  Future<NextEvent> loadNextEvent({required String groupId});
}

class LoadNextEventSpyRepository implements LoadNextEventRepository {
  String? groupId;
  int callsCount = 0;
  NextEvent? output;

  @override
  Future<NextEvent> loadNextEvent({required String groupId}) async {
    callsCount++;
    this.groupId = groupId;
    return output!;
  }
}

void main() {
  late Faker faker;
  late String groupId;
  late LoadNextEventSpyRepository repo;
  late NextEventLoader sut;

  setUpAll(() {
    faker = Faker();
  });

  setUp(() {
    groupId = faker.randomGenerator.integer(5000).toString();
    repo = LoadNextEventSpyRepository();
    repo.output = NextEvent(
      groupName: 'any_group_name',
      date: DateTime.now(),
      players: [
        NextEventPlayer(
          id: faker.hashCode.toString(),
          name: faker.person.name(),
          isConfirmed: faker.randomGenerator.boolean(),
          photo: faker.randomGenerator.hashCode.toString(),
          confirmationDate: DateTime.now(),
        ),
        NextEventPlayer(
          id: faker.hashCode.toString(),
          name: faker.person.name(),
          isConfirmed: faker.randomGenerator.boolean(),
          position: faker.randomGenerator.hashCode.toString(),
          confirmationDate: DateTime.now(),
        ),
      ],
    );
    sut = NextEventLoader(repo: repo);
  });

  test('should load event data from a repository', () async {
    await sut(groupId: groupId);
    expect(repo.groupId, groupId);
    expect(repo.callsCount, 1);
  });

  test('should return event data on success', () async {
    final event = await sut(groupId: groupId);
    expect(event.groupName, repo.output?.groupName);
    expect(event.date, repo.output?.date);
    expect(event.players.length, 2);
    for (var i = 0; i < event.players.length; i++) {
      if (i == 1) {
        expect(event.players[i].photo, repo.output?.players[i].photo);
      } else {
        expect(event.players[i].position, repo.output?.players[i].position);
      }

      expect(event.players[i].id, repo.output?.players[i].id);
      expect(event.players[i].name, repo.output?.players[i].name);
      expect(event.players[i].initials, isNotEmpty);
      expect(event.players[i].isConfirmed, repo.output?.players[i].isConfirmed);
      expect(
        event.players[i].confirmationDate,
        repo.output?.players[i].confirmationDate,
      );
    }
  });
}

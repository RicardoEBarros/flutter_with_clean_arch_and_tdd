import 'package:advanced_flutter/domain/entities/next_event.dart';
import 'package:advanced_flutter/domain/repositories/load_next_event_repository.dart';

final class NextEventLoader {
  final LoadNextEventRepository repo;

  const NextEventLoader({required this.repo});

  // call => método que não precisa ser "invocado"
  Future<NextEvent> call({required String groupId}) async {
    return repo.loadNextEvent(groupId: groupId);
  }
}

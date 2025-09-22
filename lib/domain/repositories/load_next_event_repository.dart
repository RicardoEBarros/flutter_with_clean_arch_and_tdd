import 'package:advanced_flutter/domain/entities/next_event.dart';

// abstract interface => não permite que classes estendam (extends) dela
abstract interface class LoadNextEventRepository {
  Future<NextEvent> loadNextEvent({required String groupId});
}

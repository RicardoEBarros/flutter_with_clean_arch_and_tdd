import 'package:rxdart/rxdart.dart';

import 'package:advanced_flutter/domain/entities/next_event.dart';
import 'package:advanced_flutter/presentation/presenters/next_event_presenter.dart';
import 'package:advanced_flutter/presentation/viewmodel/next_event_viewmodel.dart';

final class NextEventRxPresenter implements NextEventPresenter {
  final Future<NextEvent> Function({required String groupId}) nextEventLoader;
  final nextEventSubject = BehaviorSubject<NextEventViewModel>();
  final isBusySubject = BehaviorSubject<bool>();

  NextEventRxPresenter({required this.nextEventLoader});

  @override
  Stream<bool> get isBusyStream => isBusySubject.stream;

  @override
  Stream<NextEventViewModel> get nextEventStream => nextEventSubject.stream;

  @override
  Future<void> loadNextEvent({required String groupId, bool isReload = false}) async {
    try {
      if (isReload) isBusySubject.add(true);
      final event = await nextEventLoader(groupId: groupId);
      nextEventSubject.add(NextEventViewModel.fromEntity(event));
    } catch (error) {
      nextEventSubject.addError(error);
    } finally {
      if (isReload) isBusySubject.add(false);
    }
  }
}

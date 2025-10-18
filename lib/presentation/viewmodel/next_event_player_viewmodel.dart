import 'package:advanced_flutter/domain/entities/next_event_player.dart';
import 'package:dartx/dartx.dart';

final class NextEventPlayerViewModel {
  final String name;
  final String initials;
  final String? photo;
  final String? position;
  final bool? isConfirmed;

  const NextEventPlayerViewModel({required this.name, required this.initials, this.photo, this.position, this.isConfirmed});

  factory NextEventPlayerViewModel.fromEntity(NextEventPlayer player) => NextEventPlayerViewModel(
    name: player.name,
    initials: player.initials,
    photo: player.photo,
    position: player.position,
    isConfirmed: player.confirmationDate == null ? null : player.isConfirmed,
  );

  static List<NextEventPlayerViewModel> _mapPlayers(List<NextEventPlayer> players) =>
      players.map(NextEventPlayerViewModel.fromEntity).toList();

  static List<NextEventPlayerViewModel> mapDoubtPlayers(List<NextEventPlayer> players) =>
      _mapPlayers(players.where((player) => player.confirmationDate == null).sortedBy(_sortedByName));

  static List<NextEventPlayerViewModel> mapGoalkeepers(List<NextEventPlayer> players) =>
      _mapPlayers(_in(players).where((player) => player.position == 'goalkeeper').sortedBy(_sortedByDate));

  static List<NextEventPlayerViewModel> mapInPlayers(List<NextEventPlayer> players) =>
      _mapPlayers(_in(players).where((player) => player.position != 'goalkeeper').sortedBy(_sortedByDate));

  static List<NextEventPlayerViewModel> mapOutPlayers(List<NextEventPlayer> players) =>
      _mapPlayers(_confirmed(players).where((player) => !player.isConfirmed).sortedBy(_sortedByDate));

  static Iterable<NextEventPlayer> _confirmed(List<NextEventPlayer> players) => players.where((player) => player.confirmationDate != null);
  static Iterable<NextEventPlayer> _in(List<NextEventPlayer> players) => _confirmed(players).where((player) => player.isConfirmed);
  static Comparable _sortedByName(NextEventPlayer player) => player.name;
  static Comparable _sortedByDate(NextEventPlayer player) => player.confirmationDate!;
}

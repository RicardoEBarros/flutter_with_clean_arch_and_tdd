import 'package:advanced_flutter/infra/types/json.dart';

import 'mapper.dart';
import 'package:advanced_flutter/domain/entities/next_event_player.dart';

final class NextEventPlayerMapper extends Mapper<NextEventPlayer> {
  @override
  NextEventPlayer toObject(dynamic json) {
    return NextEventPlayer(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      photo: json['photo'],
      confirmationDate: DateTime.tryParse(json['confirmationDate'] ?? ''),
      isConfirmed: json['isConfirmed'],
    );
  }

  JsonArr toJsonArr(List<NextEventPlayer> players) => players.map(toJson).toList();

  Json toJson(NextEventPlayer player) => {
    'id': player.id,
    'name': player.name,
    'position': player.position,
    'photo': player.photo,
    'confirmationDate': player.confirmationDate?.toIso8601String(),
    'isConfirmed': player.isConfirmed,
  };
}

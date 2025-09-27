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
      confirmationDate: json['confirmationDate'],
      isConfirmed: json['isConfirmed'],
    );
  }
}

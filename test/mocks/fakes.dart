import 'package:advanced_flutter/domain/entities/next_event.dart';
import 'package:advanced_flutter/domain/entities/next_event_player.dart';
import 'package:advanced_flutter/infra/types/json.dart';
import 'package:faker/faker.dart';

String anyString() => anyInt().toString();
bool anyBool() => faker.randomGenerator.boolean();
DateTime anyDate() => faker.date.dateTime();
String anyIsoDate() => anyDate().toIso8601String();
int anyInt([int max = 5000]) => faker.randomGenerator.integer(max);
Json anyJson() => {anyString(): anyString()};
JsonArr anyJsonArr() => List.generate(anyInt(5), (index) => anyJson());
NextEventPlayer anyNextEventPlayer() => NextEventPlayer(id: anyString(), name: anyString(), isConfirmed: anyBool());
List<NextEventPlayer> anyNextEventPlayerList() => List.generate(5, (index) => anyNextEventPlayer());
NextEvent anyNextEvent() => NextEvent(groupName: anyString(), date: anyDate(), players: anyNextEventPlayerList());

import 'package:faker/faker.dart';

String anyString() => anyInt().toString();
bool anyBool() => faker.randomGenerator.boolean();
DateTime anyDate() => faker.date.dateTime();
String anyIsoDate() => anyDate().toIso8601String();
int anyInt() => faker.randomGenerator.integer(5000);

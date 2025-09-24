import 'package:faker/faker.dart';

String anyString() => faker.randomGenerator.integer(5000).toString();
bool anyBool() => faker.randomGenerator.boolean();
DateTime anyDate() => faker.date.dateTime();

import 'package:faker/faker.dart';

String anyString() => faker.randomGenerator.integer(5000).toString();

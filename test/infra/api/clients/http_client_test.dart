import 'package:faker/faker.dart';
import 'package:http/http.dart';

import 'package:flutter_test/flutter_test.dart';

import 'client_spy.dart';

class HttpClient {
  final Client client;

  HttpClient({required this.client});

  Future<void> get({required String url}) async {
    await client.get(Uri.parse(url));
  }
}

void main() {
  late Faker faker;
  late String url;
  late ClientSpy client;
  late HttpClient sut;

  setUpAll(() {
    faker = Faker();
  });

  setUp(() {
    client = ClientSpy();
    url = faker.internet.httpUrl();
    sut = HttpClient(client: client);
  });

  group('get', () {
    test('should request with correct method', () async {
      await sut.get(url: url);
      expect(client.method, 'get');
      expect(client.callsCount, 1);
    });

    test('should request with correct url', () async {
      await sut.get(url: url);
      expect(client.url, url);
    });
  });
}

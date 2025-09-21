import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';

import '../../../helpers/fakes.dart';

class LoadNextEventApiRepository {
  final HttpGetClient httpClient;
  final String url;

  LoadNextEventApiRepository({required this.httpClient, required this.url});

  Future<void> loadNextEvent({required String groupId}) async {
    await httpClient.get(url: url, params: {"groupId": groupId});
  }
}

abstract class HttpGetClient {
  Future<void> get({required String url, Map<String, String>? params});
}

class HttpGetClientSpy implements HttpGetClient {
  String? url;
  int callsCount = 0;
  Map<String, String>? params;

  @override
  Future<void> get({required String url, Map<String, String>? params}) async {
    this.url = url;
    this.params = params;
    callsCount++;
  }
}

void main() {
  late Faker fake;
  late String groupId;
  late String url;
  late HttpGetClientSpy httpClient;
  late LoadNextEventApiRepository sut;

  setUpAll(() {
    fake = Faker();
  });

  setUp(() {
    groupId = anyString();
    url = fake.internet.httpUrl();
    httpClient = HttpGetClientSpy();
    sut = LoadNextEventApiRepository(httpClient: httpClient, url: url);
  });

  test('should call HttpClient with correct input', () async {
    await sut.loadNextEvent(groupId: groupId);
    expect(httpClient.url, url);
    expect(httpClient.params, {"groupId": groupId});
    expect(httpClient.callsCount, 1);
  });
}

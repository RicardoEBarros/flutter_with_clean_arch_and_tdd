import 'package:flutter_test/flutter_test.dart';

import 'package:advanced_flutter/infra/types/json.dart';
import 'package:advanced_flutter/infra/mappers/mapper.dart';
import 'package:advanced_flutter/domain/entities/next_event_player.dart';
import 'package:advanced_flutter/infra/mappers/next_event_mapper.dart';

import '../../mocks/fakes.dart';

final class ListMapperSpy<Dto> extends ListMapper<Dto> {
  dynamic toDtoListInput;
  int toDtoListCallsCount = 0;
  List<Dto> toDtoListOutput;

  ListMapperSpy({required this.toDtoListOutput});

  @override
  List<Dto> toDtoList(dynamic arr) {
    toDtoListInput = arr;
    toDtoListCallsCount++;
    return toDtoListOutput;
  }

  @override
  Dto toDto(Json json) => throw UnimplementedError();

  @override
  Json toJson(Dto dto) => throw UnimplementedError();
}

void main() {
  late NextEventMapper sut;
  late ListMapperSpy<NextEventPlayer> playerMapper;

  setUp(() {
    playerMapper = ListMapperSpy(toDtoListOutput: anyListNextEventPlayer());
    sut = NextEventMapper(playerMapper: playerMapper);
  });

  test('should map to dto', () {
    final json = {"groupName": anyString(), "date": '2024-08-29T11:00:00.000', "players": anyJsonArr()};
    final dto = sut.toDto(json);
    expect(dto.groupName, json['groupName']);
    expect(dto.date, DateTime(2024, 8, 29, 11, 0));
    expect(playerMapper.toDtoListInput, json['players']);
    expect(playerMapper.toDtoListCallsCount, 1);
    expect(dto.players, playerMapper.toDtoListOutput);
  });
}

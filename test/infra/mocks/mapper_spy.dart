import 'package:advanced_flutter/infra/mappers/mapper.dart';
import 'package:advanced_flutter/infra/types/json.dart';

import '../../mocks/fakes.dart';

final class MapperSpy<Dto> implements Mapper<Dto> {
  Json? toDtoInput;
  int toDtoInputCallsCount = 0;
  int toJsonCallsCount = 0;
  Dto toDtoOutput;
  Dto? toJsonInput;
  Json toJsonOutput = anyJson();

  MapperSpy({required this.toDtoOutput});

  @override
  Dto toDto(Json json) {
    toDtoInput = json;
    toDtoInputCallsCount++;
    return toDtoOutput;
  }

  @override
  Json toJson(Dto dto) {
    toJsonInput = dto;
    toJsonCallsCount++;
    return toJsonOutput;
  }
}

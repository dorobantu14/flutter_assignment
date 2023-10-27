import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_entity.freezed.dart';

@freezed
class PersonEntity with _$PersonEntity {
  const factory PersonEntity({
    required String name,
    List<String>? lastTripsLocations
  }) = _PersonEntity;
}
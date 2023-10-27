part of 'persons_bloc.dart';

enum PersonsStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class PersonsState with _$PersonsState {
  const factory PersonsState({
    @Default(PersonsStatus.initial) status,
    @Default([]) List<PersonEntity> persons,
  }) = _PersonsState;
}
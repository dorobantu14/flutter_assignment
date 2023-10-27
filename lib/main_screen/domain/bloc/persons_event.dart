part of 'persons_bloc.dart';

@freezed
class PersonsEvent with _$PersonsEvent {
  const factory PersonsEvent.getPersons() = _getPersonsEvent;

  const factory PersonsEvent.addPersonInput({
    required String personName,
    required List<String> input,
  }) = _addPersonInput;
}

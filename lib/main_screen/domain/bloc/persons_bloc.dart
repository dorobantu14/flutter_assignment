import 'dart:async';
import 'package:flutter_assignment1/main_screen/entity/person_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'persons_event.dart';

part 'persons_bloc.freezed.dart';

part 'persons_state.dart';

class PersonsBloc extends Bloc<PersonsEvent, PersonsState> {
  PersonsBloc() : super(const PersonsState()) {
    on<_getPersonsEvent>(_onGetPersonsEvent);
    on<_addPersonInput>(_onPersonInput);
  }

  FutureOr<void> _onGetPersonsEvent(
    _getPersonsEvent event,
    Emitter<PersonsState> emit,
  ) {
    emit(state.copyWith(status: PersonsStatus.loading));
    emit(
      state.copyWith(
        status: PersonsStatus.success,
        persons: List.generate(
          10,
          (index) => PersonEntity(name: 'Person ${index + 1}'),
        ),
      ),
    );
  }

  FutureOr<void> _onPersonInput(
    _addPersonInput event,
    Emitter<PersonsState> emit,
  ) {
    emit(state.copyWith(status: PersonsStatus.loading));

    var newList = [...state.persons];
    final personIndex = newList.indexWhere((person) => person.name == event.personName);
    newList[personIndex] = PersonEntity(
      name: event.personName,
      lastTripsLocations: event.input,
    );
    emit(state.copyWith(status: PersonsStatus.success, persons: newList));
  }
}

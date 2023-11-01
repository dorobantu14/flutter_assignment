import 'package:flutter_assignment1/main_screen/domain/bloc/persons_bloc.dart';
import 'package:flutter_assignment1/main_screen/entity/person_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Main bloc test', () {
    test('Get persons test', () {
      final personsBloc = PersonsBloc();
      final expectedStates = [
        const PersonsState(
          status: PersonsStatus.loading,
          persons: [],
        ),
        PersonsState(
          status: PersonsStatus.success,
          persons: List.generate(
            10,
            (index) => PersonEntity(name: 'Person ${index + 1}'),
          ),
        ),
      ];
      expect(
        personsBloc.stream,
        emitsInOrder(expectedStates),
      );
      personsBloc.add(const PersonsEvent.getPersons());
    });

    test('Add person input test', () {
      final personsBloc = PersonsBloc();
      final personsList = List.generate(
        10,
        (index) => PersonEntity(name: 'Person ${index + 1}'),
      );

      final listAfterInput = personsList.map((person) {
        if (person.name == 'Person 1') {
          return const PersonEntity(
            name: 'Person 1',
            lastTripsLocations: ['input'],
          );
        }
        return person;
      }).toList();
      final expectedStates = [
        const PersonsState(
          status: PersonsStatus.loading,
          persons: [],
        ),
        PersonsState(
          status: PersonsStatus.success,
          persons: personsList,
        ),
         PersonsState(
          status: PersonsStatus.loading,
          persons: personsList,
        ),
        PersonsState(
          status: PersonsStatus.success,
          persons: listAfterInput,
        ),
      ];

      expect(
        personsBloc.stream,
        emitsInOrder(expectedStates),
      );

      personsBloc.add(const PersonsEvent.getPersons());
      personsBloc.add(
        const PersonsEvent.addPersonInput(
          personName: 'Person 1',
          input: ['input'],
        ),
      );
    });
  });
}

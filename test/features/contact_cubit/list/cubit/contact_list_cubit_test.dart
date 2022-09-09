import 'package:bloc_test/bloc_test.dart';
import 'package:contact_name/features/contact_cubit/list/cubit/contact_list_cubit.dart';
import 'package:contact_name/model/contact_model.dart';
import 'package:contact_name/repository/contacts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactRepository extends Mock implements ContactsRepository {}

void main() {
  late ContactsRepository repository;
  late ContactListCubit cubit;
  late List<ContactModel> contacts;

  setUp(() {
    repository = MockContactRepository();
    cubit = ContactListCubit(contactsRepository: repository);
    contacts = [
      ContactModel(
        id: 1,
        name: 'Ricardo Le',
        email: 'Ricardo.filho@t.com.br',
      ),
      ContactModel(
        id: 2,
        name: 'Juk Le',
        email: 'Julia.filha@t.com.br',
      ),
    ];
  });

  blocTest<ContactListCubit, ContactListCubitState>(
    'Buscar dados lista',
    build: () => cubit,
    act: (cubit) => cubit.findAll(),
    setUp: () {
      when(
        () => repository.findAll(),
      ).thenAnswer((_) async => contacts);
    },
    expect: () => [
      ContactListCubitState.loading(),
      ContactListCubitState.data(contacts: contacts),
    ],
  );
}

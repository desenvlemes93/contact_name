import 'package:bloc_test/bloc_test.dart';
import 'package:contact_name/features/contacts_bloc/list/bloc/contact_list_bloc.dart';
import 'package:contact_name/model/contact_model.dart';
import 'package:contact_name/repository/contacts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mocktail/mocktail.dart';

class MockContactRepository extends Mock implements ContactsRepository {}

void main() {
  late ContactsRepository repository;
  late ContactListBloc bloc;
  late List<ContactModel> contacts;

  setUp(() {
    repository = MockContactRepository();
    bloc = ContactListBloc(repository: repository);
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

  blocTest<ContactListBloc, ContactListState>(
    'Buscar dados lista',
    build: () => bloc,
    act: (bloc) => bloc.add(const ContactListEvent.findAll()),
    setUp: () {
      when(
        () => repository.findAll(),
      ).thenAnswer((_) async => contacts);
    },
    expect: () => [
      ContactListState.loading(),
      ContactListState.data(contacts: contacts),
    ],
  );
}

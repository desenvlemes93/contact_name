import 'package:bloc_test/bloc_test.dart';
import 'package:contact_name/features/contact_cubit/register/cubit/contact_register_cubit.dart';
import 'package:contact_name/model/contact_model.dart';
import 'package:contact_name/repository/contacts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactRepository extends Mock implements ContactsRepository {}

void main() {
  late ContactsRepository repository;
  late ContactRegisterCubit cubit;
  late ContactModel contacts;

  setUp(() {
    repository = MockContactRepository();
    cubit = ContactRegisterCubit(repository: repository);
    contacts = const ContactModel(
      id: 1,
      name: 'Ricardo Le',
      email: 'Ricardo.filho@t.com.br',
    );
  });

  blocTest<ContactRegisterCubit, ContactRegisterCubitState>(
    'Buscar dados lista',
    build: () => cubit,
    act: (cubit) => cubit.saveRegister(
      id: 2,
      email: 'Ricarod',
      nome: 'Joagin',
    ),
    setUp: () {
      when(
        () => repository.create(contacts),
      ).thenAnswer((_) async => {});
    },
    expect: () => [
      ContactRegisterCubitState.loading(),
      //   ContactRegisterCubitState.data(contacts: contacts),
    ],
  );
}

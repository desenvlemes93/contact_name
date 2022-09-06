import 'package:contact_name/model/contact_model.dart';
import 'package:dio/dio.dart';

class ContactsRepository {
  final String urlName = 'http://192.168.0.103:3001/contacts';
  Future<List<ContactModel>> findAll() async {
    final response = await Dio().get('http://192.168.0.103:3001/contacts');

    return response.data
        ?.map<ContactModel>((contact) => ContactModel.fromMap(contact))
        .toList();
  }

  Future<void> create(ContactModel model) => Dio().post(
        'http://192.168.0.103:3001/contacts/${model.id}}',
        data: model.toMap(),
      );

  Future<void> update(ContactModel model) => Dio().put(
        'http://192.168.0.103:3001/contacts/${model.id}',
        data: model.toMap(),
      );

  Future<void> delete(ContactModel model) =>
      Dio().delete('$urlName/${model.id}');

  Future<int> findId() async {
    final response = await Dio().get('http://192.168.0.103:3001/contacts');

    return response.data.last['id'];
  }
}

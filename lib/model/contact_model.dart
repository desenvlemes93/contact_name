import 'package:equatable/equatable.dart';

class ContactModel {
  final int id;
  final String name;
  final String email;
  const ContactModel({
    required this.id,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  @override
  String toString() => 'ContactModel(id: $id, name: $name, email: $email)';

  ContactModel copyWith({
    int? id,
    String? name,
    String? email,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}

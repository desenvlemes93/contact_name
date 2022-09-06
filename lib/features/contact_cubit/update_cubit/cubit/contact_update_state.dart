part of 'contact_update_cubit.dart';

@freezed
class ContactUpdateState with _$ContactUpdateState {
 const   factory ContactUpdateState.initial() = _Initial;
 const   factory ContactUpdateState.success() = _Success;
  const  factory ContactUpdateState.data({required List<ContactModel>}) = _Data;
const   factory ContactUpdateState.Error({required String message}) = _Error;
}

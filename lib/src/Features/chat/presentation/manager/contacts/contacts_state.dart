part of 'contacts_cubit.dart';

@immutable
abstract class ContactsState {}

class ContactsInitial extends ContactsState {}

class RefreshContactsState extends ContactsState {}

class DoneContactsState extends ContactsState {}

class ErrorContactsState extends ContactsState {
  final String message;
  ErrorContactsState(this.message);
}
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/contact.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  Future<void> fetchContacts() async {
    final query = QueryBuilder(ParseObject('Contact'));
    final response = await query.query();
    if (response.success && response.results != null) {
      _contacts = response.results!.map((e) => Contact.fromParse(e)).toList();
      notifyListeners();
    }
  }

  Future<void> addContact(Contact contact) async {
    final parseObj = contact.toParse();
    final response = await parseObj.save();
    if (response.success) {
      await fetchContacts();
    }
  }

  Future<void> updateContact(int index, Contact contact) async {
    final response = await contact.toParse().save();
    if (response.success) {
      await fetchContacts();
    }
  }

  Future<void> deleteContact(int index) async {
    final contact = _contacts[index];
    final response = await ParseObject('Contact')..objectId = contact.objectId;
    final deleteResponse = await response.delete();
    if (deleteResponse.success) {
      await fetchContacts();
    }
  }
}

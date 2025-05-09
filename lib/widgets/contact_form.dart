import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/contact.dart';
import '../providers/contact_provider.dart';

class ContactForm extends StatefulWidget {
  final Contact? contact;
  final int? index;

  const ContactForm({super.key, this.contact, this.index});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late int age;
  late String mobile;

  @override
  void initState() {
    super.initState();
    name = widget.contact?.name ?? '';
    age = widget.contact?.age ?? 0;
    mobile = widget.contact?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.contact != null;
    return AlertDialog(
      title: Text(isEditing ? 'Edit Contact' : 'Add Contact'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                initialValue: age.toString(),
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                // Added a validator to check if the input is a number
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter age';
                  if (int.tryParse(value) == null) return 'Enter a valid number';
                  return null;
                },
                onSaved: (value) => age = int.parse(value!),
              ),
              TextFormField(
                initialValue: mobile,
                decoration: const InputDecoration(labelText: 'Mobile Number'),
                validator: (value) => value!.isEmpty ? 'Enter mobile' : null,
                onSaved: (value) => mobile = value!,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text(isEditing ? 'Update' : 'Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final contact = Contact(name: name, age: age, mobile: mobile);
              final provider = Provider.of<ContactProvider>(context, listen: false);
              if (isEditing) {
                provider.updateContact(widget.index!, contact);
              } else {
                provider.addContact(contact);
              }
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

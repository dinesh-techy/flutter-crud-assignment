import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/contact_provider.dart';
import '../widgets/contact_form.dart';

class ContactHomePage extends StatefulWidget {
  const ContactHomePage({super.key});

  @override
  State<ContactHomePage> createState() => _ContactHomePageState();
}

class _ContactHomePageState extends State<ContactHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ContactProvider>(context, listen: false).fetchContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: ListView.builder(
        itemCount: contactProvider.contacts.length,
        itemBuilder: (context, index) {
          final contact = contactProvider.contacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text('Age: ${contact.age}, Mobile: ${contact.mobile}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => ContactForm(
                      contact: contact,
                      index: index,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => contactProvider.deleteContact(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const ContactForm(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

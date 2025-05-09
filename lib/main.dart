import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/contact.dart';
import 'providers/contact_provider.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContactProvider(),
      child: MaterialApp(
        title: 'Contact CRUD App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ContactHomePage(),
      ),
    );
  }
}
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Contact {
  String? objectId;
  String name;
  int age;
  String mobile;

  Contact({
    this.objectId,
    required this.name,
    required this.age,
    required this.mobile,
  });

  // ✅ Convert Contact to ParseObject
  ParseObject toParse() {
    final obj = ParseObject('Contact');

    if (objectId != null) {
      obj.objectId = objectId; // Needed for update
    }

    obj
      ..set('name', name)
      ..set('age', age)
      ..set('mobile', mobile);

    return obj;
  }

  // ✅ Convert ParseObject to Contact
  factory Contact.fromParse(ParseObject obj) {
    return Contact(
      objectId: obj.objectId,
      name: obj.get<String>('name') ?? '',
      age: obj.get<int>('age') ?? 0,
      mobile: obj.get<String>('mobile') ?? '',
    );
  }
}

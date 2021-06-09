import 'package:exampleapp/ui/firestore/firestore_user.dart';
import 'package:flutter/material.dart';

class FirestoreUserItem extends StatelessWidget {
  final FirestoreUser user;

  const FirestoreUserItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${user.firstName} ${user.lastName}"),
      subtitle: Text("${user.age}"),
    );
  }
}

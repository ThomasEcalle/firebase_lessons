import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(home: Home()),
  );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Add user"),
              onPressed: _addUser,
            ),
            ElevatedButton(
              child: Text("Add Dummy data"),
              onPressed: _addDummyData,
            ),
            ElevatedButton(
              child: Text("Update Dummy data"),
              onPressed: _addDummyData,
            ),
            ElevatedButton(
              child: Text("Retrieve users"),
              onPressed: _retrieveUsers,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addUser() async {
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

    try {
      final DocumentReference created =
          await usersCollection.add({"first_name": "John", "last_name": "Doe", "age": 42});
      print("User added ${created.id}");
    } catch (error) {
      print("Failed to add user: $error");
    }
  }

  Future<void> _addDummyData() async {
    final CollectionReference ref = FirebaseFirestore.instance.collection('users/unidentifiant/friends');

    try {
      await ref.add({"first_name": "John", "last_name": "Doe", "age": 42});
      print("Friend added");
    } catch (error) {
      print("Failed to add user: $error");
    }
  }

  Future<void> _retrieveUsers() async {
    final CollectionReference ref = FirebaseFirestore.instance.collection('users');

    try {
      final QuerySnapshot snap = await ref.get();
      print("${snap.docs}");
    } catch (error) {
      print("Failed to add user: $error");
    }
  }
}

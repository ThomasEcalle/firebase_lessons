import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exampleapp/ui/firestore/firestore_user.dart';
import 'package:exampleapp/ui/firestore/firestore_user_item.dart';
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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("usersExercise").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.active:
                final List<QueryDocumentSnapshot> documents = snapshot.data?.docs ?? [];
                if (documents.isEmpty) {
                  return Text("Aucun utilisateur !");
                } else {
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      final QueryDocumentSnapshot document = documents[index];
                      final FirestoreUser? user = FirestoreUser.fromJson(document.data() as Map<String, dynamic>?);
                      if (user == null) {
                        return SizedBox();
                      }
                      return FirestoreUserItem(user: user);
                    },
                  );
                }
              default:
                return Text("Aucun utilisateur !");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addUser,
      ),
    );
  }

  Future<void> _addUser() async {
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('usersExercise');

    try {
      final DocumentReference created = await usersCollection.add({
        "first_name": "John",
        "last_name": "Doe",
        "age": 42,
      });
      print("User added ${created.id}");
    } catch (error) {
      print("Failed to add user: $error");
    }
  }
}

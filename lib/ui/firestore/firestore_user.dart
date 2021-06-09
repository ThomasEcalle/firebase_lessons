class FirestoreUser {
  final String firstName;
  final String lastName;
  final int age;

  FirestoreUser({
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  static FirestoreUser? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return FirestoreUser(
      firstName: json["first_name"],
      lastName: json["last_name"],
      age: json["age"],
    );
  }
}

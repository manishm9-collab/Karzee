import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser({
    required String uid,
    required String email,
    required String role, // freelancer / client
  }) async {
    await _db.collection('users').doc(uid).set({
      'email': email,
      'role': role,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<DocumentSnapshot> getUser(String uid) {
    return _db.collection('users').doc(uid).snapshots();
  }
}

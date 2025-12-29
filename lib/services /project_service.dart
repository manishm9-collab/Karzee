import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // POST PROJECT
  Future<void> postProject({
    required String title,
    required String description,
    required String budget,
    required String ownerId,
  }) async {
    await _db.collection('projects').add({
      'title': title,
      'description': description,
      'budget': budget,
      'ownerId': ownerId,
      'status': 'open',
      'createdAt': Timestamp.now(),
    });
  }

  // GET ALL PROJECTS
  Stream<QuerySnapshot> getAllProjects() {
    return _db
        .collection('projects')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/constants/exceptions.dart';

class DataRepository {
  final FirebaseFirestore db;

  DataRepository({required this.db});

  Future<void> set(String id) async {
    try {
      await db.collection('users').doc(id);
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> update(String id, data) async {
    try {
      await db
          .collection('users')
          .doc(id)
          .set({'Profile': data}, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }
}

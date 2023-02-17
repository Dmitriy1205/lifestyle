import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifestyle/data/models/workout.dart';

import '../../common/constants/exceptions.dart';

class DataRepository {
  final FirebaseFirestore db;

  DataRepository({required this.db});

  Future<void> setUser(String id) async {
    try {
      db.collection('users').doc(id);
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> setProfile(String id, data) async {
    try {
      await db
          .collection('users')
          .doc(id)
          .set({'profile': data}, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> setExercises(
      String id, Map<String, dynamic> data, String workoutId) async {
    try {
      await db
          .collection('users')
          .doc(id)
          .collection('workouts')
          .doc(workoutId)
          .set(data, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<Workout>> getOwnWorkouts(String id) async {
    try {
      final data =
          await db.collection('users').doc(id).collection('workouts').get();

      return data.docs.map((e) => Workout.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<Workout>> getAllWorkouts() async {
    try {
      final data = await db.collectionGroup('workouts').get();

      return data.docs.map((e) => Workout.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }
}

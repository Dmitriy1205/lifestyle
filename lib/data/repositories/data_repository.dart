import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifestyle/data/models/profile.dart';
import 'package:lifestyle/data/models/workout.dart';

import '../../common/constants/exceptions.dart';
import '../models/files.dart';

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

  Future<ProfileModel> getProfile(String id) async {
    try {
      final data = await db.collection('users').doc(id).get();
      if (!data.exists) {
        return ProfileModel();
      }
      return ProfileModel.fromJson(data.data()!['profile']);
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    } on Exception catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

  Future<List<Files>> getFiles({required String source}) async {
    try {
      final files = await db.collection('files').doc(source).get();

      return (files.data()!['files'] as List)
          .map((e) => Files.fromJson(e))
          .toList();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message.toString());
    }
  }
}

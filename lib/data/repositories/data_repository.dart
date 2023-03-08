import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifestyle/data/models/profile.dart';
import 'package:lifestyle/data/models/workout.dart';

import '../../common/constants/exceptions.dart';
import '../models/files.dart';

class DataRepository {
  final FirebaseFirestore db;

  DataRepository({required this.db});

  late Source _source;

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

  Future<Source> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _source = Source.serverAndCache;
      }
    } on SocketException catch (_) {
      _source = Source.cache;
    }
    return _source;
  }

  Future<List<Workout>> getOwnWorkouts(String id) async {
    try {
      final src = await isConnected();
      final data = await db
          .collection('users')
          .doc(id)
          .collection('workouts')
          .get(GetOptions(source: src));

      return data.docs.map((e) => Workout.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<Workout>> getAllWorkouts() async {
    try {
      final src = await isConnected();
      final data =
          await db.collectionGroup('workouts').get(GetOptions(source: src));

      return data.docs.map((e) => Workout.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<ProfileModel> getProfile(String id) async {
    try {
      final src = await isConnected();
      final data =
          await db.collection('users').doc(id).get(GetOptions(source: src));
      if (!data.exists) {
        return ProfileModel();
      }
      return ProfileModel.fromJson(data.data()!['profile'] ?? {});
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    } on Exception catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

  Future<List<Files>> getFiles({required String source}) async {
    try {
      final src = await isConnected();
      final files =
          await db.collection('files').doc(source).get(GetOptions(source: src));

      return (files.data()!['files'] as List)
          .map((e) => Files.fromJson(e))
          .toList();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message.toString());
    }
  }

  Future<List<Files>> getAllFiles() async {
    try {
      final src = await isConnected();
      final files = await db.collection('files').get(GetOptions(source: src));

      return files.docs.map((e) => Files.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }
}

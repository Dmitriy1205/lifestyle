import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../../common/constants/exceptions.dart';
import '../models/files.dart';

class StorageRepository {
  final FirebaseStorage storage;

  StorageRepository({required this.storage});

  Future<String> upload(File? source, String destination) async {
    try {
      UploadTask task = storage.ref(destination).putFile(source!);
      await task;
      return await task.snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message.toString());
    }
  }

  Future<void> update(File source, String destination) async {
    try {
      await storage.ref(destination).putFile(source);
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message.toString());
    }
  }

  Future<List<Files>> getFiles(String source, List<Files> listFiles) async {
    try {
      ListResult files = await storage.ref(source).listAll();

      for (var ref in files.items) {
        FullMetadata data = await storage.ref(ref.fullPath).getMetadata();
        String url = await storage.ref(ref.fullPath).getDownloadURL();

        if (listFiles.length != files.items.length) {
          listFiles.add(Files(
              name: data.name.substring(0, data.name.indexOf('.')),
              url: url,
              creationDate: data.timeCreated.toString()));
        }
      }

      return listFiles;
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message.toString());
    }
  }
}

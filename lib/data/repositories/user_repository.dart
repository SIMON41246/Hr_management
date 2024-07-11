// Ensure this path is correct

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app_rh/data/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository {
  static final FirebaseFirestore _userCollection = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> addUser(User user) async {
    try {
      await _userCollection.collection("USERS").doc(user.id!).set(User.toJson(user));
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await _userCollection.doc(user.id!).update(User.toJson(user));
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _userCollection.collection("USERS").doc(id).delete();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  Future<User?> getUser(String id) async {
    try {
      DocumentSnapshot doc =
          await _userCollection.collection("USERS").doc(id).get();
      if (doc.exists) {
        return User.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  Future<List<User>> getUsers() async {
    final List<User> users = [];
    final QuerySnapshot<Map<String, dynamic>> deliveriesCollection =
        await _userCollection.collection("USERS").get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> deliveryJson
        in deliveriesCollection.docs) {
      User delivery = User.fromJson(deliveryJson.data());
      users.add(delivery);
    }

    return users;
  }

  static Future<String> saveImage(
      {required String imgName, required String imgPath}) async {
    final saveImg = await _firebaseStorage
        .ref()
        .child(imgName)
        .putFile(File(imgPath));
    final imgUrl = await saveImg.ref.getDownloadURL();
    return imgUrl;
  }

  static Future<String> saveRib(
      {required String ribName, required String ribPath}) async {
    final saveImg = await _firebaseStorage
        .ref()
        .child(ribName)
        .putFile(File(ribPath));
    final imgUrl = await saveImg.ref.getDownloadURL();
    return imgUrl;
  }

  static Future<String> saveContrat(
      {required String contratName, required String contratPath}) async {
    final saveImg = await _firebaseStorage
        .ref()
        .child(contratName)
        .putFile(File(contratPath));
    final imgUrl = await saveImg.ref.getDownloadURL();
    return imgUrl;
  }

  static Future<String> saveCV(
      {required String cvName, required String cvPath}) async {
    final saveImg =
        await _firebaseStorage.ref().child(cvName).putFile(File(cvPath));
    final imgUrl = await saveImg.ref.getDownloadURL();
    return imgUrl;
  }

  static Future<String> saveCin(
      {required String cinName, required String cinPath}) async {
    final saveImg = await _firebaseStorage
        .ref()
        .child(cinName)
        .putFile(File(cinPath));
    final imgUrl = await saveImg.ref.getDownloadURL();
    return imgUrl;
  }

  static Future<String> saveDiplome(
      {required String diplomName, required String diplomePath}) async {
    final saveImg = await _firebaseStorage
        .ref()
        .child(diplomName)
        .putFile(File(diplomePath));
    final imgUrl = await saveImg.ref.getDownloadURL();
    return imgUrl;
  }
}

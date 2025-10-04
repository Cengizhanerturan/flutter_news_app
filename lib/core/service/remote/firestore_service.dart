import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_news_app/core/constants/firestore_constants.dart';
import 'package:flutter_news_app/core/model/user_model.dart';
import 'package:get/get.dart';

class FirestoreService extends GetxService {
  late final FirebaseFirestore _firestore;

  @override
  void onInit() {
    super.onInit();
    _firestore = FirebaseFirestore.instance;
  }

  Future<bool> _addDocumentWithId(
    String collectionPath,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).set(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _updateDocument(
    String collectionPath,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).update(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ignore: unused_element
  Future<bool> _deleteDocument(String collectionPath, String documentId) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getDocument(
    String collectionPath,
    String documentId,
  ) async {
    try {
      return await _firestore.collection(collectionPath).doc(documentId).get();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> _isExistField(
    String collectionPath,
    String checkField,
    String checkValue,
  ) async {
    try {
      var querySnapshot =
          await _firestore
              .collection(collectionPath)
              .where(checkField, isEqualTo: checkValue)
              .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUser(String userId) async {
    try {
      var documentSnapshot = await _getDocument(
        FirestoreConstants.usersCollection,
        userId,
      );
      if (documentSnapshot.exists) {
        if (documentSnapshot.data() == null) {
          return null;
        }
        return UserModel.fromJson(documentSnapshot.data()!);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createUser(UserModel userModel) async {
    try {
      var userJson = userModel.toJson();
      return await _addDocumentWithId(
        FirestoreConstants.usersCollection,
        userModel.userId,
        userJson,
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(UserModel userModel) async {
    try {
      var userId = userModel.userId;
      var userJson = userModel.toJson();
      return await _updateDocument(
        FirestoreConstants.usersCollection,
        userId,
        userJson,
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      return await _isExistField(
        FirestoreConstants.usersCollection,
        'email',
        email,
      );
    } catch (e) {
      return false;
    }
  }
}

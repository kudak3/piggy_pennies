import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piggy_pennies/model/api_response.dart';
import 'package:piggy_pennies/model/child.dart';
import 'package:piggy_pennies/model/chore.dart';
import 'package:piggy_pennies/model/user.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection("users");

  final CollectionReference _childrenCollectionReference =
      Firestore.instance.collection("children");

      final CollectionReference _choresCollectionReference =
      Firestore.instance.collection("chores");


  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.uid).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future registerChild(Child child) async {
    try {
      await _childrenCollectionReference
          .document(child.uid)
          .setData(child.toJson());

      return APIResponse<bool>(error: false);
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.message);
    }
  }

    Future registerChore(Chore chore) async {
    try {
      await _choresCollectionReference
          .document(chore.id)
          .setData(chore.toJson());

      return APIResponse<bool>(error: false);
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.message);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:piggy_pennies/model/api_response.dart';
import 'package:piggy_pennies/model/child.dart';
import 'package:piggy_pennies/model/chore.dart';
import 'package:piggy_pennies/model/user.dart';

import 'authentication_service.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection("users");

  final CollectionReference _childrenCollectionReference =
      Firestore.instance.collection("children");

      final CollectionReference _choresCollectionReference =
      Firestore.instance.collection("chores");

        AuthenticationService get authenticationService =>
      GetIt.I<AuthenticationService>();


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
      String ui = await authenticationService.currentUser();
      chore.createdBy = ui;
        
    try {
      await _choresCollectionReference
          .document(chore.id)
          .setData(chore.toJson());

      return APIResponse<bool>(error: false);
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.message);
    }
  }

  Stream<List<Child>> getChildrenByParentId() async*{
      User user = await authenticationService.currentUser();
      List<Child> children;
      
    _childrenCollectionReference
    .where("parentId", isEqualTo: user.uid)
    .snapshots()
    .listen((data) =>
        data.documents.forEach((doc) => children.add(Child.fromJson(doc.data))));
        yield children;
  }


  Future getChildren() async{
      User user = await authenticationService.currentUser();
      List<Child> children;
      
    _childrenCollectionReference
    .where("parentId", isEqualTo: user.uid)
    .snapshots()
    .listen((data) =>
        data.documents.forEach((doc) => children.add(Child.fromJson(doc.data))));
        return children;
  }

   Stream<List<Child>> getAllowancesByChildId() async*{
      String ui = await authenticationService.currentUser();
      List<Child> children;
      
    _childrenCollectionReference
    .where("parentId", isEqualTo: ui)
    .snapshots()
    .listen((data) =>
        data.documents.forEach((doc) => children.add(Child.fromJson(doc.data))));
        yield children;
  }

    Stream<List<Child>> getChores(String status,String childId) async*{
      String ui = await authenticationService.currentUser();
      List<Child> children;
      
    _childrenCollectionReference
    .where("parentId", isEqualTo: ui)
    .snapshots()
    .listen((data) =>
        data.documents.forEach((doc) => children.add(Child.fromJson(doc.data))));
        yield children;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get_it/get_it.dart';
import 'package:piggy_pennies/model/allowance.dart';
import 'package:piggy_pennies/model/api_response.dart';
import 'package:piggy_pennies/model/child.dart';
import 'package:piggy_pennies/model/chore.dart';
import 'package:piggy_pennies/model/goal.dart';
import 'package:piggy_pennies/model/user.dart';

import '../model/chore.dart';
import 'authentication_service.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection("users");

  final CollectionReference _childrenCollectionReference =
      Firestore.instance.collection("children");

  final CollectionReference _choresCollectionReference =
      Firestore.instance.collection("chores");

  final CollectionReference _allowanceCollectionReference =
      Firestore.instance.collection("allowances");


  final CollectionReference _goalCollectionReference =
      Firestore.instance.collection("goals");

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
    User u = await authenticationService.currentUser();
    print("user id =====");
    print(u.uid);
    child.parentId = u.uid;
    print("parent id ====");
    print(child.parentId);
    try {
      await _childrenCollectionReference
          .document(child.fullName)
          .setData(child.toJson());

      return APIResponse<bool>(error: false);
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.message);
    }
  }

  Future registerChore(Chore chore) async {
    print("=============chore ==");
    User ui = await authenticationService.currentUser();
    chore.createdBy = ui.uid;
    print("=============chore ==");
    print(chore);

    try {
      await _choresCollectionReference
          .document(chore.name)
          .setData(chore.toJson());

      return APIResponse<bool>(error: false);
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.message);
    }
  }

  Future createAllowance(Allowance allowance) async {
    print("=============chore ==");
    allowance.paid = false;

    try {
      await _allowanceCollectionReference
          .document(allowance.child.fullName)
          .setData(allowance.toJson());

      return APIResponse<bool>(error: false);
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.message);
    }
  }

  Future addGoal(Goal goal) async {
    print("=============chore ==");
  

    try {
      await _goalCollectionReference
          .document(goal.goalName)
          .setData(goal.toJson());

      return APIResponse<bool>(error: false);
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.message);
    }
  }

  // Stream<List<Child>> getChildrenByParentId() async* {
  //   User user = await authenticationService.currentUser();
  //   List<Child> children;

  //   _childrenCollectionReference
  //       .where("parentId", isEqualTo: user.uid)
  //       .snapshots()
  //       .listen((data) => data.documents
  //           .forEach((doc) => children.add(Child.fromJson(doc.data))));
  //   yield children;
  // }

  Future getGoals(String name) async {
 


    QuerySnapshot querySnapShot = await _goalCollectionReference
        .where('childName', isEqualTo: name)
        .getDocuments();
    print('userid =====list');
    print(querySnapShot.documents
        .map(
          (e) => Goal.fromJson(e.data),
        )
        .toList());

    return querySnapShot.documents
        .map(
          (e) => Goal.fromJson(e.data),
        )
        .toList();

  }

  Future getAllowances(String allowance) async {
  

    QuerySnapshot querySnapShot = await _allowanceCollectionReference
        .where('choreName', isEqualTo: allowance)
        .getDocuments();
    print('userid =====list');
    print(querySnapShot.documents
        .map(
          (e) => Allowance.fromJson(e.data),
        )
        .toList());

    return querySnapShot.documents
        .map(
          (e) => Allowance.fromJson(e.data),
        )
        .toList();

  }

    Future getChildren() async {
      User user = await authenticationService.currentUser();
   

      QuerySnapshot querySnapShot = await _childrenCollectionReference
          .where("parentId", isEqualTo: user.uid)
          .getDocuments();
      print('userid =====list');
      print(querySnapShot.documents
          .map(
            (e) => Child.fromJson(e.data),
          )
          .toList());

      return querySnapShot.documents
          .map(
            (e) => Child.fromJson(e.data),
          )
          .toList();
    
    }

    Stream<List<Child>> getAllowancesByChildId() async* {
      String ui = await authenticationService.currentUser();
      List<Child> children;

      _childrenCollectionReference
          .where("parentId", isEqualTo: ui)
          .snapshots()
          .listen((data) => data.documents
              .forEach((doc) => children.add(Child.fromJson(doc.data))));
      yield children;
    }

    // Stream<List<Child>> getChores(String status, String childId) async* {
    //   String ui = await authenticationService.currentUser();
    //   List<Child> children;

    //   _childrenCollectionReference
    //       .where("parentId", isEqualTo: ui)
    //       .snapshots()
    //       .listen((data) => data.documents
    //           .forEach((doc) => children.add(Child.fromJson(doc.data))));
    //   yield children;
    
    // }

    Future getChores(Child child) async {
      User user = await authenticationService.currentUser();
   

      QuerySnapshot querySnapShot = await _choresCollectionReference
          .where("assigness", arrayContains: child)
          .getDocuments();
   

      return querySnapShot.documents
          .map(
            (e) => Chore.fromJson(e.data),
          )
          .toList();
    
    }
  }


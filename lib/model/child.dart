import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';


part 'child.g.dart';

@JsonSerializable()
class Child{
   String uid;
  String fullName;
  String birthDate;
  String gender;
  String parentId;
  String photoUrl;
  double  balance;



  Child(
      {this.uid,
      this.fullName,
      this.birthDate,
      this.gender,
      this.parentId,
      this.photoUrl,
      this.balance,
     
     });

      @override
  String toString() {
    return 'Child{uid:$uid,displayName:$fullName,birthDate:$birthDate,parentId:$parentId,photoUrl:$photoUrl,gender:$gender,balance:$balance}';
  }



  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);

 
  Map<String, dynamic> toJson() => _$ChildToJson(this);



}
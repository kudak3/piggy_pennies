import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class Goal{
  String gid;
  String goalName;
  String amount;




  Goal(
      {this.gid,
        this.goalName,
        this.amount,
      });

  @override
  String toString() {
    return 'Goal{gid:$gid,goalName:$goalName,amount:$amount}';
  }





}
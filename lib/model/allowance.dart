import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'chore.dart';


part 'allowance.g.dart';

@JsonSerializable(explicitToJson: true)
class Allowance{
   String uid;
Chore chore;
bool paid;

  Allowance(
      {this.uid,
      this.chore,
      this.paid,
      
     
     });

      @override
  String toString() {
    return 'Allowance{uid:$uid,chore:$chore,paid:$paid}';
  }



  factory Allowance.fromJson(Map<String, dynamic> json) => _$AllowanceFromJson(json);

 
  Map<String, dynamic> toJson() => _$AllowanceToJson(this);



}
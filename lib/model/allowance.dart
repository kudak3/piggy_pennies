
import 'package:json_annotation/json_annotation.dart';

import 'child.dart';
import 'chore.dart';


part 'allowance.g.dart';

@JsonSerializable(explicitToJson: true)
class Allowance{
   String uid;
   Child child;
Chore chore;
String choreName;
bool paid;
String amount;

  Allowance(
      {this.uid,
      this.chore,
      this.paid,
      this.child,
      this.choreName,
      this.amount,
     
     });

      @override
  String toString() {
    return 'Allowance{uid:$uid,chore:$chore,paid:$paid,child:child}';
  }



  factory Allowance.fromJson(Map<String, dynamic> json) => _$AllowanceFromJson(json);

 
  Map<String, dynamic> toJson() => _$AllowanceToJson(this);



}
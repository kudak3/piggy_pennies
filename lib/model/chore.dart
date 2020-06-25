

import 'package:json_annotation/json_annotation.dart';
import 'package:piggy_pennies/model/child.dart';


part 'chore.g.dart';

@JsonSerializable(explicitToJson: true)
class Chore{
   String id;
  String name;
  String price;
  String dueDate;
  String frequency;
  String photoUrl;
  String notes;
  String createdBy;
  String status;
  List<Child> assignees;



  Chore(
      {this.id,
      this.name,
      this.price,
      this.dueDate,
      this.frequency,
      this.photoUrl,
      this.notes,
      this.createdBy,
      this.status,
      this.assignees,
     
     });

      @override
  String toString() {
    return 'Chore{id:$id,name:$name,price:$price,frequency:$frequency,photoUrl:$photoUrl,status:$status}';
  }



  factory Chore.fromJson(Map<String, dynamic> json) => _$ChoreFromJson(json);

 
  Map<String, dynamic> toJson() => _$ChoreToJson(this);



}
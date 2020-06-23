

import 'package:json_annotation/json_annotation.dart';


part 'chore.g.dart';

@JsonSerializable()
class Chore{
   String id;
  String name;
  String price;
  String dueDate;
  String frequency;
  String photoUrl;



  Chore(
      {this.id,
      this.name,
      this.price,
      this.dueDate,
      this.frequency,
      this.photoUrl,
     
     });

      @override
  String toString() {
    return 'Chore{id:$id,name:$name,price:$price,frequency:$frequency,photoUrl:$photoUrl}';
  }



  factory Chore.fromJson(Map<String, dynamic> json) => _$ChoreFromJson(json);

 
  Map<String, dynamic> toJson() => _$ChoreToJson(this);



}

import 'package:json_annotation/json_annotation.dart';

part 'goal.g.dart';

@JsonSerializable()
class Goal{
  String gid;
  String childName;
  String goalName;
  String cost;
  String store;




  Goal(
      {this.gid,
        this.goalName,
        this.cost,
        this.childName,
        this.store,
      });

  @override
  String toString() {
    return 'Goal{gid:$gid,goalName:$goalName,amount:$cost}';
  }

 factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

 
  Map<String, dynamic> toJson() => _$GoalToJson(this);





}
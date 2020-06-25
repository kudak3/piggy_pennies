// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return Goal(
    gid: json['gid'] as String,
    goalName: json['goalName'] as String,
    cost: json['cost'] as String,
    childName: json['childName'] as String,
    store: json['store'] as String,
  );
}

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'gid': instance.gid,
      'childName': instance.childName,
      'goalName': instance.goalName,
      'cost': instance.cost,
      'store': instance.store,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Child _$ChildFromJson(Map<String, dynamic> json) {
  return Child(
    uid: json['uid'] as String,
    fullName: json['fullName'] as String,
    birthDate: json['birthDate'] as String,
    gender: json['gender'] as String,
    parentId: json['parentId'] as String,
    photoUrl: json['photoUrl'] as String,
    balance: (json['balance'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'uid': instance.uid,
      'fullName': instance.fullName,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
      'parentId': instance.parentId,
      'photoUrl': instance.photoUrl,
      'balance': instance.balance,
    };

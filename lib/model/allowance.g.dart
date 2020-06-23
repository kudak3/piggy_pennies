// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Allowance _$AllowanceFromJson(Map<String, dynamic> json) {
  return Allowance(
    uid: json['uid'] as String,
    chore: json['chore'] == null
        ? null
        : Chore.fromJson(json['chore'] as Map<String, dynamic>),
    paid: json['paid'] as bool,
  );
}

Map<String, dynamic> _$AllowanceToJson(Allowance instance) => <String, dynamic>{
      'uid': instance.uid,
      'chore': instance.chore?.toJson(),
      'paid': instance.paid,
    };

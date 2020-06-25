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
    child: json['child'] == null
        ? null
        : Child.fromJson(json['child'] as Map<String, dynamic>),
    choreName: json['choreName'] as String,
    amount: json['amount'] as String,
  );
}

Map<String, dynamic> _$AllowanceToJson(Allowance instance) => <String, dynamic>{
      'uid': instance.uid,
      'child': instance.child?.toJson(),
      'chore': instance.chore?.toJson(),
      'choreName': instance.choreName,
      'paid': instance.paid,
      'amount': instance.amount,
    };

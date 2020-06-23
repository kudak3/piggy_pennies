// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chore _$ChoreFromJson(Map<String, dynamic> json) {
  return Chore(
    id: json['id'] as String,
    name: json['name'] as String,
    price: json['price'] as String,
    dueDate: json['dueDate'] as String,
    frequency: json['frequency'] as String,
    photoUrl: json['photoUrl'] as String,
    notes: json['notes'] as String,
  );
}

Map<String, dynamic> _$ChoreToJson(Chore instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'dueDate': instance.dueDate,
      'frequency': instance.frequency,
      'photoUrl': instance.photoUrl,
      'notes': instance.notes,
    };

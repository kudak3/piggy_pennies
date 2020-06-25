
import 'package:json_annotation/json_annotation.dart';


part 'user.g.dart';

@JsonSerializable()
class User{
   String uid;
  String displayName;
  String email;
  String photoUrl;



  User(
      {this.uid,
      this.displayName,
      this.email,
      this.photoUrl,
     
     });

      @override
  String toString() {
    return 'User{uid:$uid,displayName:$displayName,email:$email,photoUrl:$photoUrl}';
  }



  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

 
  Map<String, dynamic> toJson() => _$UserToJson(this);



}
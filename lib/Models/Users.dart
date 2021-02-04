import 'package:flutter/foundation.dart';

class User{
  String userid;
  String username;
  String fullname;
  String email;
  String photoURL;
  String location;
  String settings;
  String datecreated;

User({
  this.userid,
  this.username,
  this.fullname,
  this.email,
  this.photoURL,
  this.location,
  this.settings,
  this.datecreated
});

factory User.fromMap(Map<dynamic, dynamic>map){
  return User(
  userid: map['id'],
  username: map['username'],
  fullname: map['fulname'],
  email: map['email'],
  photoURL: map['photoURL'],
    location: map['location'],
    settings: map['settings'],
    datecreated: map['datecreated'],
  );
  //definiton of unique user
}
}

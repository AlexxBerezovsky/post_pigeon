import 'Users.dart';

class Groups{
  String id;
  String name;
  List <User> members;
  Groups ({
    this.id,
    this.members,
    this.name
  });
  factory Groups.fromMap (Map <dynamic, dynamic> map){
    var members = map['members'] as List;
    List memberList = members.map((user)=>User.fromMap(user)).toList();
    return Groups(
      id: map['id'],
      name: map['name'],
      members: memberList
    );
    //counting members in one group
  }
}

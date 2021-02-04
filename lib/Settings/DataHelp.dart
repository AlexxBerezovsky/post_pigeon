import 'package:post_pigeon/Models/Users.dart';
import 'package:post_pigeon/Models/Groups.dart';
import 'package:post_pigeon/Models/Messages.dart';

class DataHepl {
  bool doesMessageSenderAndReceiverExist(Messages messages, List<Messages> list, List<User> users) {
    for (int i = 0; i < list.length; i++) {
      if (((messages.senderid == getidFromusername(list[i].receiverid, users))
          &&
          (messages.receiverid == getusernameFromid(list[i].senderid, users)))
          ||
          (messages.senderid == list[i].senderid
              &&
              messages.receiverid == list[i].receiverid)
      ) {
        return true;
      }
    }
    return false;
  }
}
String getusernameFromid(String id, List<User> users)
{
  for(int i=0; i < users.length; i++)
  {
    if(users[i].userid == id)
    {
      return users[i].username;
    }
  }
  return "";
}

String getidFromusername(String username, List<User> users){
  String id = "";
  for(int i = 0;i < users.length; i++){
    if(users[i].username == username){
      id = users[i].userid;
    }
  }
  return id;
}

User getusernameFromusername(String username, List<User> users){
  User user;
  for(int i = 0; i <users.length; i++){
    if(users[i].username == username){
      user = users[i];
    }
  }
  return user;
}
User getuserFromid(String id, List<User> users){
  for(int i = 0; i< users.length; i++){
    if(users[i].userid == id){
      return users[i];
    }
  }
  return null;
}

String getavatarofuserFromusername(String username, List<User> users){
  for(int i = 0; i<users.length; i++){
    if(users[i].username == username){
      return users[i].photoURL;
    }
  }
  return null;
}
String getavatarofuserFromid(String id, List<User> users){
  for(int i = 0;i<users.length; i++){
    if(users[i].userid == id){
      return users[i].photoURL;
    }
  }
  return null;
}
// next logic step getGropuVia..
Groups getgroupviaid(String id, List<Groups>groups){
  Groups group;
  for(int i = 0; i < groups.length; i++){
    if(groups[i].id == id){
      group = groups[i];
    }
  }
  return group;
}
bool userbelongTogroup(User user, Groups group){
  bool belongs = false;
  for(int i = 0; i <group.members.length; i++ ){
    if(user.userid == group.members[i].userid){
      belongs = true;
    }
  }
  return belongs;
}
int numberOfunreadmessages(List<Messages> messages){
  int unread = 0;
  messages.forEach((element) {
    if(element.read == false){
      unread +=1;
    }
  });
  return unread;
}
int numberOfreadmessages(List<Messages> messages){
  int read = 0;
  messages.forEach((element) {
    if(element.read == true){
      read +=1;
    }
  });
  return read;
}
void readAllmessages(List<Messages> messages){
  messages.forEach((element) {
    element.read = true;
  });
}



















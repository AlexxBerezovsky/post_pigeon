import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:post_pigeon/Settings/CurrentUser.dart';
import 'package:post_pigeon/Models/Groups.dart';
import 'package:post_pigeon/Models/Messages.dart';
import 'package:post_pigeon/Models/Users.dart';

class DatabaseService
{

  final CollectionReference contactsCollection = Firestore.instance.collection('Contacts');
  final CollectionReference messageCollection = Firestore.instance.collection('Messages');
  final CollectionReference userCollection = Firestore.instance.collection('Users');
  final CollectionReference groupCollection = Firestore.instance.collection('Groups');

  Future addUserToDatabase(String id, String username, String fullname, String email, String photoURL,
      String bio, String location, String dateCreated, String settings) async
  {


    return await userCollection.document(id).setData({
      'id': id,
      'username': username,
      'fullname': fullname,
      'email': email,
      'photourl': photoURL,
      'bio': bio,
      'location': location,
      'datecreated': dateCreated,
      'settings': settings

    });
  }
  Future addChat(Messages messages) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    return await messageCollection.document().setData({
      'sender': messages.senderid,
      'receiver': messages.receiverid,
      'receivedat': messages.receivedAt,
      'message': messages.message,
      'messagetype': messages.messageType,
      'messagereceivertype' : messages.messageRecivierType,
      'read' : messages.read
    });
  }
  Future addGroup( Groups group) async {
    return await groupCollection.document().setData({
      'id': groupCollection.document().documentID,
      'name' : group.name,
      'members' : group.members.map((group) => {
        'id': group.userid,
        'username': group.username,
        'fullname': group.fullname,
        'email': group.email
      }).toList(),
    });
  }
  List<Messages> getMessageListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Messages(
          senderid: doc.data['sender'] ?? '',
          receiverid: doc.data['receiver'] ?? '',
          receivedAt: doc.data['receivedat'] ?? '',
          message: doc.data['message'] ?? '',
          messageType: doc.data['messagetype'] ?? '',
          messageRecivierType: doc.data['messagereceivertype'] ?? '',
          read: doc.data['read']
      );
    }).toList();
  }
  List<User> getUsersFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return User(
        userid: doc.data['id'],
        username: doc.data['username'],
        fullname: doc.data['fullname'],
        email: doc.data['email'],
        photoURL: doc.data['photourl'],
        biography: doc.data['bio'],
        location: doc.data['location'],
        datecreated: doc.data['datecreated'],
        settings: doc.data['settings'],
      );
    }).toList();
  }
  List<Groups> getGroupsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc)
    {
      Map groupMap = Map<dynamic, dynamic>.from(doc.data);
      Groups group = Groups.fromMap(groupMap);
      return group;
    }
    ).toList();
  }
  Future updateUserDP(String url) async {
    return await userCollection.document(CurrentUser.user.userid).updateData({
      'photourl' : url
    });
  }
  Stream<List<Messages>> get messages {
    return messageCollection.orderBy('receivedat').snapshots().map(getMessageListFromSnapshots);
  }
  Stream<List<User>> get users {
    return userCollection.snapshots().map(getUsersFromSnapshot);
  }
  Stream<List<Groups>> get groups {
    return groupCollection.snapshots().map(getGroupsFromSnapshot);
  }
}

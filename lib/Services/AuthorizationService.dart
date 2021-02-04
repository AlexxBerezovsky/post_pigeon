import 'package:post_pigeon/Models/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:post_pigeon/Services/DatabaseService.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  User convertFirebaseUserToUser(FirebaseUser user) {
    return user != null ? User(userid: user.uid) : null;
  }
  Stream<User> get user {
    return auth.onAuthStateChanged.map(convertFirebaseUserToUser);
  }
  Future signIn(String email, String password) async {
    try {
      AuthResult result =  await auth.signInWithEmailAndPassword(email: email, password: password);

      FirebaseUser user = result.user;

      return convertFirebaseUserToUser(user);

    }
    catch(e){}
  }
  Future registerEmailPassword(String username, String fullname, String email, String password) async{
    try{
      AuthResult result =  await auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService().addUserToDatabase(user.uid, username, fullname, email, "",
          "Oh, hi there, I'm using f***ing post pigeon",
          "", DateTime.now().toString(), "");
      return convertFirebaseUserToUser(user);
    }
    catch(e){}
  }
  Future signOut() async{
    try{
      return await auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}
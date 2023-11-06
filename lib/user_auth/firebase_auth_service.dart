



import 'package:firebase_auth/firebase_auth.dart';

import '../global/common/toast.dart';

class Firebase_Auth_Service{

  FirebaseAuth _auth = FirebaseAuth.instance;


  Future<User?> signUpWithEmailAndPassword(String email, String password) async {

    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          return credential.user;
    }on FirebaseException catch(e){
        if(e.code == "email-already-in-use"){
          failedShowToast(message:'This email is already in registered.');
        }else{
          failedShowToast(message:'an error occurred: ${e.code}');
        }
    }


    return null;
  }


  /// log in logic
  Future<User?> signInWithEmailAndPassword(String email, String password) async {

    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }on FirebaseException catch(e){
      if(e.code == 'user-not-found' || e.code == 'wrong-password'){
        failedShowToast(message:'Invalid email or password');
      }else{
        failedShowToast(message:'An error occurred: ${e.code}');
      }

    }
    return null;
  }
}

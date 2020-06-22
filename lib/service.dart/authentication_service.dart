import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:piggy_pennies/model/api_response.dart';
import 'package:piggy_pennies/model/user.dart';

class AuthenticationService {
final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//signup with email
  Future signUpWithEmail(String email, String password, String username) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        UserUpdateInfo updateInfo = UserUpdateInfo();
        updateInfo.displayName = username;
        await authResult.user.updateProfile(updateInfo);
        await authResult.user.reload();
        FirebaseUser updatedUser = await _firebaseAuth.currentUser();

         return APIResponse<User>(
        error: false,
        data: User(
          uid: updatedUser.uid,
          displayName: updatedUser.displayName,
          email: updatedUser.email,
        ),
      );
      
      } else {
        return  APIResponse<bool>(error: true, errorMessage: 'User registration failed');
      }

     
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.message);
    }
  }


  //signin with email
    Future signInWithEmail(String email, String password) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        

         return APIResponse<User>(
        error: false,
        data: User(
          uid: authResult.user.uid,
          displayName: authResult.user.displayName,
          email: authResult.user.email,
        ),
      );
      
      } else {
        return  APIResponse<bool>(error: true, errorMessage: 'Login failed');
      }

     
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.message);
    }
  }

//signup with google 
  Future signUpWithGoogle() async {
       try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

   final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

 final FirebaseUser user = (await _firebaseAuth.signInWithCredential(credential)).user;

      if (user != null) {
       
         return APIResponse<User>(
        error: false,
        data: User(
          uid: user.uid,
          displayName: user.displayName,
          email: user.email,
          photoUrl:user.photoUrl,
        ),
      );
      
      } else {
        return  APIResponse<bool>(error: true, errorMessage: 'User registration failed');
      }

     
    } catch (e) {
      return APIResponse<bool>(error: true, errorMessage: e.message);
    }
  }

//signin
  Future loginWithEmail(String email, String password) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user != null;
    } catch (e) {
      return e.message;
    }
  }
}

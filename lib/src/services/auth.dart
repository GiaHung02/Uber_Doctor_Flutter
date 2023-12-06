// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   UserModel _userFromFirebase(User? user) {
//     if (user == null) {
//       return UserModel(uid: 'null');
//     }
//     return UserModel(uid: user.uid);
//   }

//   Stream<UserModel> get user {
//     return _auth.authStateChanges().map(_userFromFirebase);
//   }

//   Stream<UserModel> get idTokenChanges {
//     return _auth.idTokenChanges().map(_userFromFirebase);
//   }

//   Stream<UserModel> get userChanges {
//     return _auth.userChanges().map(_userFromFirebase);
//   }

//   Future<UserModel> signInWithEmailAndPassword(String email,String password) async {
//     try {
//       UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       User? user = credential.user;
//       return _userFromFirebase(user);
//     } catch (e) {
//       print(e.toString());
//       return UserModel(uid: 'error');
//     }
//   }
//   Future CreateUserAnonymously(String email,String password) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(email: email, password: password);
//     } catch (e) {
//       print(e.toString());
   
//     }
//   }
//  Future signOut() async {
//      try {
//       return await _auth.signOut();
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//   Future<void> updateProfile(String displayName, String photoURL,String email,PhoneAuthCredential phoneNumber) async {
//     User? user = _auth.currentUser;
//     try {
//       await user?.updateDisplayName( displayName);
//       await user?.updatePhotoURL( photoURL);
//       await user?.updateEmail( email);
//       await user?.updatePhoneNumber( phoneNumber);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future<void> sendEmailVerification() async {
//     User? user = _auth.currentUser;
//     try {
//       await user?.sendEmailVerification();
//       // Set the language code if you want the email in a different language.
//       await _auth.setLanguageCode("fr");
//       await user?.sendEmailVerification();
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future<void> updatePassword(String newPassword) async {
//     User? user = _auth.currentUser;
//     try {
//       await user?.updatePassword(newPassword);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future<void> sendPasswordResetEmail(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//       await _auth.setLanguageCode("fr");
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future<void> deleteAccount() async {
//     User? user = _auth.currentUser;
//     try {
//       await user?.delete();
//     } catch (e) {
//       print(e.toString());
//     }
//   }
 
//   Future<void> reauthenticateUser(User user, AuthCredential credential) async {
//   try {

//     await user.reauthenticateWithCredential(credential);
//     print('Reauthentication successful');
//   } catch (e) {
//     print('Reauthentication failed: ${e.toString()}');
//   }
// }
// }

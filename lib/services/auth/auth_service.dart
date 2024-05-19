import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

class AuthService{
  // instance of auth service
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // instance of firestore service
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  User? get currentUser => _auth.currentUser;

  // sign in
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign up
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password, String fname, String lname) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      // add user to firestore
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'fname': fname,
        'lname': lname,
        'isDeactivated': false,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // get user data
  Future<Map<String, dynamic>?> getUserData(currentUserId) async {
    final doc = _firestore.collection("Users").doc(currentUserId);
    final snapshot = await doc.get();
    if (snapshot.exists) {
      return snapshot.data();
    } else {
      return null;
    }
  }
}
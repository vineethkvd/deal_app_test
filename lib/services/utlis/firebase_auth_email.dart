import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  //User is a inbuilt class in firebase auth
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      /*Here, it attempts to create a new user account by calling the
      createUserWithEmailAndPassword method of the FirebaseAuth instance.*/
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      /*If the user registration is successful,
      it extracts the user object from the UserCredential and assigns it to the user variable.*/
      user = userCredential.user;
      //This line updates the user's display name with the provided name.
      await user!.updateDisplayName(name);
      /*This line reloads the user's data to ensure that the display name update is reflected immediately.*/
      await user.reload();
      /*After reloading, it retrieves the currently authenticated user and assigns it to the user variable.*/
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }
  //refresh user
  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }
}
class FirestoreServices {
  static saveUser(String name, email, uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'email': email, 'name': name});
  }
}


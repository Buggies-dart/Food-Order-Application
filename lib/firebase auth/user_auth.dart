import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Pages/navigation.dart';
import 'package:food_delivery_app/admin/adminhome.dart';
import 'package:food_delivery_app/firebase%20auth/firebaseutils.dart';
import 'package:food_delivery_app/user%20onboarding/login.dart';
class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  Future<void> signUpWithEmail({
    required String username,
    required String mail,
    required String password,
    required String address,
    required BuildContext context,
  }) async {
    try {
      _auth.setLanguageCode('en');
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      // Add user to Firestore if sign-up succeeds
      String uid = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username,
        'email': mail,
        'address': address,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Send email verification
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        if (context.mounted) {
          showSnackbar(context, 'Email verification sent. Please verify.');
        }
      }
    } on FirebaseAuthException catch (e) {
      // Provide a default error message if `e.message` is null
      final errorMessage = e.message ?? 'An error occurred during sign-up';
      if (context.mounted) {
        showSnackbar(context, errorMessage);
      }
    }
  }

  Future<void> userSignin({
    required String mail,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
      if (_auth.currentUser != null && !_auth.currentUser!.emailVerified) {
        if(context.mounted){
    showSnackbar(context, 'Email not verified. Please verify.');
        }
      } else {
        if (context.mounted) {
    showSnackbar(context, 'Sign-in successful!');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const Navigation();
    }));
        }
      }
    } on FirebaseAuthException catch (e) {
      final errorMessage = e.message ?? 'An error occurred during sign-in';
      if (context.mounted) {
        showSnackbar(context, errorMessage);
      }
    }
  }
  
// RESET PASSWORD
 Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      if (context.mounted) {
        showSnackbar(context, 'Password reset email sent. Check your inbox.');
      }
    } on FirebaseAuthException catch (e) {
      final errorMessage = e.message ?? 'Failed to send password reset email';
      if (context.mounted) {
        showSnackbar(context, errorMessage);
      }
}
  }
  //  Admin Login
  Future<void> adminLogin(String id, String password, BuildContext context) async {
  try {
    // Query Firestore for an admin with the provided name and password
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Admin')
        .where('id', isEqualTo: id)
        .where('password', isEqualTo: password)
        .get();

    // Check if any document matches the query
    if (querySnapshot.docs.isNotEmpty) {
      // If a document is found, navigate to the admin home page
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Adminhome(),
          ),
        );
      }
    } else {
      // If no document matches, show an error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
        const  SnackBar(content: Text('User not found or incorrect credentials')),
        );
      }
    }
  } catch (e) {
    // Catch and display any errors that occur during login
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}

// DELETE USER ACCOUNT
Future<void> deleteAccount(BuildContext context) async{
final user = FirebaseAuth.instance.currentUser;
showDialogBox(context, () async{
  if (user != null) {
    try {
  // Delete user's Firestore data
 await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
 // Delete user's authentication account
await user.delete();
// Sign out the user and navigate back to a welcome or login screen
await FirebaseAuth.instance.signOut();
if (context.mounted) {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
const LoginUI()));
}
 } catch (e) {
  if (context.mounted) {
  showSnackbar(context, 'Failed to delete your account\n Try again Later');    
  }
    }
  }
}, (){
  Navigator.pop(context);
}, 'We hate to see you go!', 'Are You sure you want to delete your account?');
}

// USER LOGOUT

Future<void> signOut(BuildContext context) async{
final user = FirebaseAuth.instance.currentUser;
if (user!=null) {
  showDialogBox(context, () async{
    try {
    await FirebaseAuth.instance.signOut();
if (context.mounted) {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
const LoginUI()));
}
  } catch (e) {
    if (context.mounted) {
   showSnackbar(context, 'An unexpected error occurred');
    }
  }
  }, (){
    Navigator.pop(context);
  }, 'SIGN OUT', 'Are you sure you want to sign out?');
  
}
}
// CONFIRM PASSWORD
Future<void> confirmPassword(BuildContext context, String password, TextEditingController controller) async{
  final user = FirebaseAuth.instance.currentUser;

try {
  if(user != null){
    final credential = EmailAuthProvider.credential(
      email: user.email!, // User's email
      password: password, // Password entered by the user
    );
  await user.reauthenticateWithCredential(credential);
  if (context.mounted) {
    showChangeAddressModal(context, (){
      changeAddress(context, controller.text);
      Navigator.pop(context);
    }, controller);
  }
   
 }
} catch (e) {
  if (context.mounted) {
  showSnackbar(context, 'Wrong Password, try again');
   
  }
}
}
// UPDATE USER ADDRESS
Future<void> changeAddress(BuildContext context, String addressChanged) async{
 final userId = FirebaseAuth.instance.currentUser?.uid; 
 try {
   await FirebaseFirestore.instance
    .collection('users')
    .doc(userId)
    .update({
      "address": addressChanged
    });
    if (context.mounted) {
  showUpdateAddressDialog(context);

    }
 } catch (e) {
  if (context.mounted) {
showSnackbar(context, 'Some unexpected error occurred, please try again later');

  }
 }

}
}
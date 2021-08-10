//   import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// //Facebook
//   Future<UserCredential> signInWithFacebook() async {
//     final AccessToken result = await FacebookAuth.instance.login();

//     final FacebookAuthCredential facebookAuthCredential =
//         FacebookAuthProvider.credential(result.token);

//     return await FirebaseAuth.instance
//         .signInWithCredential(facebookAuthCredential);
//   }
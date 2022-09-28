// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInUtils {
//   googleSignIn() async {
//     GoogleSignIn _googleSignIn = GoogleSignIn();

//     try {
//       var result = await _googleSignIn.signIn();
//       if (result == null) {
//         return;
//       } else {
//         final userData = await result.authentication;
//         final credentails = GoogleAuthProvider.credential(
//             accessToken: userData.accessToken, idToken: userData.idToken);

//         await FirebaseAuth.instance.signInWithCredential(credentails);
//         print("signin successfully");
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }

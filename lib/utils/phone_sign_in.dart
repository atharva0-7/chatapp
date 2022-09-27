import 'package:firebase_auth/firebase_auth.dart';

class PhoneSignIn {
  Future<String> verifyPhone(
      String phoneNumber,
      void Function(String phoneNumber, String verificationId)
          navigateToNextScreen) async {
    String verificationCode = "";
    await FirebaseAuth.instance.verifyPhoneNumber(
        codeSent: (String verificationId, int? resendToken) {
          navigateToNextScreen(phoneNumber, verificationId);
        },
        phoneNumber: "+91$phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          verificationCode = verificationID;
        });

    return verificationCode;
  }
}

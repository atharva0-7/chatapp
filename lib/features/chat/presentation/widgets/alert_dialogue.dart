import 'package:chat_app_flutter/constants/text_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constants/text_style.dart';
import '../../../login/presentation/screens/login_screen.dart';

showDialogueFunction(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Center(
          child: Text(
        kLogOutPopOutText,
        style: kLogOutTextStyle,
      )),
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        height: 120,
        child: Column(
          children: [
            Text(
              kAlertDialogueText,
              style: kCreateAnAccountToGetStartedTextStyle,
            ),
            const SizedBox(
              height: 28,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().whenComplete(() =>
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()),
                              (route) => false));
                    },
                    child: const Text('Log out'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

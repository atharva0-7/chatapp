import 'package:chat_app_flutter/constants/text_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../login/presentation/screens/login_screen.dart';

showDialogueFunction(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Center(child: kLogOutPopOutText),
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        height: 110,
        child: Column(
          children: [
            kAlertDialogueText,
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
                              MaterialPageRoute(builder: (_) => LoginScreen()),
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

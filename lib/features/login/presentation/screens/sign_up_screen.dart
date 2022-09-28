import 'package:chat_app_flutter/constants/color_constant.dart';
import 'package:chat_app_flutter/constants/text_constant.dart';
import 'package:chat_app_flutter/constants/text_style.dart';
import 'package:chat_app_flutter/features/chat/presentation/screen/bottom_navigation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  final String phoneNumber;
  final String uid;
  const SignUpScreen({Key? key, required this.phoneNumber, required this.uid})
      : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 24.0.w, right: 24.0.w, top: 61.h),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              kSignUpText,
              style: kSignUpTextStyle,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              kCreateAnAccountToGetStarted,
              style: kCreateAnAccountToGetStartedTextStyle,
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              kFirstNameText,
              style: kNameTextStyle,
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              // Enter Name
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: kTextFieldColor),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.only(left: 10.0.w),
                child: TextFormField(
                  onChanged: (value) {
                    firstName.text = value;
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: kEnterFirstNameText,
                      hintStyle: kHintTextStyle),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              kLastNameText,
              style: kNameTextStyle,
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              //Enter email
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: kTextFieldColor),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.only(left: 10.0.w),
                child: TextFormField(
                  onChanged: (value) {
                    lastName.text = value;
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: kEnterLastNameText,
                      hintStyle: kHintTextStyle),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                      splashRadius: 30,
                      side:
                          const BorderSide(color: kTextFieldColor, width: 1.5),
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      }),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    child: RichText(
                  text: TextSpan(
                    text: kIveReadAndAgreeText,
                    style: kHintTextStyle.copyWith(
                        color: kNotAMemberColor, fontSize: 12),
                    children: <TextSpan>[
                      TextSpan(
                          text: kTermsAndConditionText,
                          style: kTermsAndConditionTextStyle.copyWith(
                              color: Theme.of(context).primaryColor)),
                      TextSpan(text: kAndTheText),
                      TextSpan(
                          text: kPrivacyPolicyText,
                          style: kTermsAndConditionTextStyle.copyWith(
                              color: Theme.of(context).primaryColor)),
                    ],
                  ),
                )),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 48.h,
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  onPressed: isChecked && firstName.text != ""
                      ? () {
                          try {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.uid.toString())
                                .set({
                              'uid': widget.uid,
                              'phone_number': widget.phoneNumber,
                              'first_name': firstName.text,
                              'last_name': lastName.text,
                            }).whenComplete(() => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const BottomNavigation()),
                                    (route) => false));
                          } catch (e) {
                            print(e);
                          }
                        }
                      : null,
                  child: Text(kSignUpTextButton)),
            ),
          ]),
        ),
      ),
    );
  }
}

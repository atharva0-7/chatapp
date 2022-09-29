import 'package:chat_app_flutter/constants/text_constant.dart';
import 'package:chat_app_flutter/constants/text_style.dart';
import 'package:chat_app_flutter/features/login/presentation/screens/confirmation_code_screen.dart';

import 'package:chat_app_flutter/utils/phone_sign_in.dart';
import 'package:chat_app_flutter/utils/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneTextController = TextEditingController();
  final String verificationCode = "";
  bool clickedLogin = false;
  bool isObseured = false;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 312.h,
              width: 375.w,
              child: Image.asset("assets/image.png", fit: BoxFit.contain),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kWelcomeText,
                      style: kWelcomeTextStyle,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.length < 10 || value.length > 10) {
                          return "Enter 10 digit mobile number";
                        }
                      },
                      onChanged: (value) {
                        phoneTextController.text = value;
                      },
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          hintText: kEnterMobileText,
                          hintStyle: kHintTextStyle),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero)),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              setState(() {
                                clickedLogin = true;
                              });

                              PhoneSignIn()
                                  .verifyPhone(phoneTextController.text,
                                      navigateToNextScreen)
                                  .whenComplete(() => setState(() {
                                        clickedLogin = false;
                                      }));
                              phoneTextController.text = "";
                            }
                          },
                          child: Text(kLoginText)),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    clickedLogin
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox(),
                    const Divider(),
                    SizedBox(
                      height: 24.h,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          kOrContinueWithText,
                          style: kOrContinueWithTextStyle,
                        )),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              // await GoogleSignInUtils().googleSignIn();
                            },
                            child:
                                SvgPicture.asset("assets/google_signin.svg")),
                        SizedBox(
                          width: 12.w,
                        ),
                        SvgPicture.asset("assets/apple_signin.svg"),
                        SizedBox(
                          width: 12.w,
                        ),
                        GestureDetector(
                            onTap: () async {
                              // await FaceBookSignIn().signInWithFacebook();
                            },
                            child:
                                SvgPicture.asset("assets/facebook_signin.svg"))
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void navigateToNextScreen(String phoneNumber, String verificationId) {
    SharedPref.saveUserLoggedInSharedPreferences(true);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ConfirmationCodeScreen(
                phoneNumber: phoneNumber, verficationCode: verificationId)));
  }
}

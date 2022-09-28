import 'package:chat_app_flutter/constants/color_constant.dart';
import 'package:chat_app_flutter/constants/text_constant.dart';
import 'package:chat_app_flutter/constants/text_style.dart';
import 'package:chat_app_flutter/features/login/presentation/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmationCodeScreen extends StatefulWidget {
  final String verficationCode;
  final String phoneNumber;
  const ConfirmationCodeScreen(
      {Key? key, required this.phoneNumber, required this.verficationCode})
      : super(key: key);

  @override
  State<ConfirmationCodeScreen> createState() => _ConfirmationCodeScreenState();
}

class _ConfirmationCodeScreenState extends State<ConfirmationCodeScreen> {
  String pinValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 132.5.h),
                  child: Column(
                    children: [
                      Text(
                        kEnterConfirmationCodeText,
                        style: kEnterConfirmationCodeTextStyle,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        k4DigitCodeWasSent,
                        style: k4DigitCodeWasSentTextStyle,
                      ),
                      Text(
                        widget.phoneNumber,
                        style: k4DigitCodeWasSentTextStyle,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      PinCodeTextField(
                        textStyle: kPinCodeTextStyle,
                        pinTheme: PinTheme(
                            borderWidth: 1,
                            fieldWidth: 45,
                            fieldHeight: 48,
                            activeColor: Theme.of(context).primaryColor,
                            inactiveColor: kConfirmationCodeColor,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(
                              12.r,
                            )),
                        appContext: context,
                        length: 6,
                        onChanged: (value) {
                          setState(() {
                            pinValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          kResendCodeText,
                          style: kResendCodeTextStyle,
                        )),
                    SizedBox(
                      height: 28.5.h,
                    ),
                    SizedBox(
                      height: 48.h,
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
                            try {
                              FirebaseAuth user = FirebaseAuth.instance;
                              user
                                  .signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId:
                                              widget.verficationCode,
                                          smsCode: pinValue))
                                  .then((value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SignUpScreen(
                                              phoneNumber: widget.phoneNumber,
                                              uid: user.currentUser!.uid))));
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text(kContinueText)),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

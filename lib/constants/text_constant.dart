import 'package:chat_app_flutter/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

var kWelcomeText = Text("Welcome".tr, style: kWelcomeTextStyle);
const String kEmailAddressText = "Email Address";
String kEnterMobileText = "Enter Mobile".tr;
const String kPasswordText = "Password";
var kForgotPAsswordText =
    Text("Forgot password?", style: kForgotPasswordTextStyle);
var kLoginText = Text("Login".tr);
var kSignUpTextButton = Text("Signup".tr);
const kNotAMemberText = Text(
  "Not a member? ",
  style: kNotAMemberTextStyle,
);
var kOrContinueWithText = Text(
  "Or continue with".tr,
  style: kOrContinueWithTextStyle,
);
var kSignUpText = Text("Sign Up".tr, style: kSignUpTextStyle);
var kCreateAnAccountToGetStarted = Text(
  "Create an account to get started".tr,
  style: kCreateAnAccountToGetStartedTextStyle,
);

var kFirstNameText = Text(
  "First Name".tr,
  style: kNameTextStyle,
);
var kLastNameText = Text(
  "Last Name".tr,
  style: kNameTextStyle,
);
var kEnterPasswordText = Text(
  "Password",
  style: kNameTextStyle,
);
String kEnterFirstNameText = "Enter First Name".tr;
String kEnterLastNameText = "Enter Last Name".tr;

//  String kCreatePasswordText = "Create a password".tr;
// const String kConfirmPasswordText = "Confirm password";
String kIveReadAndAgreeText = 'I\'ve read and agree with the '.tr;
String kTermsAndConditionText = 'Terms and Conditions'.tr;
String kAndTheText = 'and the '.tr;
String kPrivacyPolicyText = 'Privacy Policy.'.tr;
const String kEnterEmailIdText = "name@email.com";
var kEnterConfirmationCodeText = Text(
  "Enter confirmation code".tr,
  style: kEnterConfirmationCodeTextStyle,
);

var k4DigitCodeWasSent = Text(
  "A 4-digit code was sent to".tr,
  style: k4DigitCodeWasSentTextStyle,
);
var kResendCodeText = Text(
  "Resend code".tr,
  style: kResendCodeTextStyle,
);

var kContinueText = Text("Continue".tr);
var kChatsTitleText = Text(
  "Chats".tr,
  style: kChatsTitleTextStyle,
);

String kLeadingEditText = "Edit".tr;
var kChatUsersText = Text(
  "Chat users".tr,
  style: kChatsTitleTextStyle.copyWith(fontSize: 16.sp),
);
var kSettingsTitleText = Text("Settings".tr, style: kSettingsTitleTextStyle);
var kSavedMesssageText = Text(
  "Saved Messages".tr,
  style: kSettingsPageOptionTextStyle,
);
var kRecentCallsText = Text(
  "Recent Calls".tr,
  style: kSettingsPageOptionTextStyle,
);
var kDevicesText = Text(
  "Devices".tr,
  style: kSettingsPageOptionTextStyle,
);
var kNotificationText = Text(
  "Notifications".tr,
  style: kSettingsPageOptionTextStyle,
);
var kAppearanceText = Text(
  "Appearance".tr,
  style: kSettingsPageOptionTextStyle,
);

String kLanguageString = "Language".tr;
String kPrivacyText = "Privacy & Security".tr;
var kPrivacyText1 = Text(
  "Privacy & Security".tr,
  style: kSettingsPageOptionTextStyle,
);
var kStorageText = Text(
  "Storage".tr,
  style: kSettingsPageOptionTextStyle,
);
var kLogOutText = Text(
  "Log Out".tr,
  style: kSettingsPageOptionTextStyle,
);
var kLogOutPopOutText = Text(
  "Log Out".tr,
  style: kLogOutTextStyle,
);
var kAlertDialogueText = Text(
  'Are you sure you want to log out? You\'ll need to login again to use the app.',
  style: kCreateAnAccountToGetStartedTextStyle,
);
const kSearchUsersText = Text(
  "Search Users",
  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
);

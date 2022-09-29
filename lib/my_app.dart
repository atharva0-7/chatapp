import 'package:chat_app_flutter/constants/color_constant.dart';

import 'package:chat_app_flutter/utils/locale_utils/language_locale.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'di/injector_config.dart';
import 'features/chat/presentation/bloc/get_chat_user_bloc/chat_user_bloc.dart';
import 'features/chat/presentation/screen/bottom_navigation_screen.dart';
import 'features/login/presentation/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final User? currentUser = FirebaseAuth.instance.currentUser;
  getCurretnUsersMessages() async {}

  // This widget is the root of your application.
  final MaterialColor colorCustom = MaterialColor(0xFF006FFD, color);

  @override
  Widget build(BuildContext context) {
    getCurretnUsersMessages();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InjectorConfig.resolve<ChatUserBloc>(),
          ),
        ],
        child: GetMaterialApp(
            translations: LocalLanguage(),
            locale: const Locale('en', 'US'),
            title: 'Chat app',
            theme: ThemeData(fontFamily: "Inter", primarySwatch: colorCustom),
            home: currentUser != null
                ? const BottomNavigation()
                : const LoginScreen()),
      ),
    );
  }
}

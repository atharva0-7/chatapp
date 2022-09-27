import 'package:chat_app_flutter/constants/color_constant.dart';
import 'package:chat_app_flutter/di/injector_config.dart';
import 'package:chat_app_flutter/features/chat/data/datasource/local/get_recent_user_impl.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/get_chat_user_bloc/chat_user_bloc.dart';
import 'package:chat_app_flutter/features/chat/presentation/screen/chat_home_screen.dart';
import 'package:chat_app_flutter/features/chat/presentation/screen/settings_screen.dart';
import 'package:chat_app_flutter/features/login/presentation/screens/confirmation_code_screen.dart';
import 'package:chat_app_flutter/features/login/presentation/screens/login_screen.dart';
import 'package:chat_app_flutter/features/login/presentation/screens/sign_up_screen.dart';
import 'package:chat_app_flutter/utils/language_locale.dart';
import 'package:chat_app_flutter/utils/shared_prefrences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'features/chat/presentation/bloc/send_message_bloc/send_message_bloc.dart';
import 'features/chat/presentation/screen/bottom_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  InjectorConfig.setup();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  User? currentUser = FirebaseAuth.instance.currentUser;

  bool isUserLoggedIn = false;
  // This widget is the root of your application.
  MaterialColor colorCustom = MaterialColor(0xFF006FFD, color);

  //SHAREDPREF TO CHECK CURRENT USER
  // getLoggedInState() {
  //   SharedPref.getUserLoggedInSharedPreferences().then((value) {
  //     setState(() {
  //       isUserLoggedIn = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    GetRecentSearchedUsersImpl().getRecentSearchedUsersSource();
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
            locale: const Locale('hi', 'IN'),
            title: 'Chat app',
            theme: ThemeData(fontFamily: "Inter", primarySwatch: colorCustom),
            home:
                currentUser != null ? const BottomNavigation() : LoginScreen()),
      ),
    );
  }
}

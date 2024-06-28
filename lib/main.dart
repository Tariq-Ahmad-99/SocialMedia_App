import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peki_media/modules/social_login/social_login_screen.dart';
import 'package:peki_media/modules/social_register/social_register_screen.dart';
import 'package:peki_media/shared/Bloc_observer.dart';
import 'package:peki_media/shared/network/local/cache_helper.dart';
import 'package:peki_media/shared/network/remote/dio_helper.dart';
import 'package:peki_media/shared/styles/themes.dart';

import 'layout/social_cubit/social_cubit.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized(); //saved small things
  
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');
  String? token = CacheHelper.getData(key: 'token');
  print(token);


  // Widget widget;

  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  //
  // if(onBoarding != null)
  // {
  //   if(token != null) {
  //     widget = const ShopLayout();
  //   } else {
  //     widget = ShopLoginScreen();
  //   }
  // }
  // else
  // {
  //   widget = const OnBoardingScreen();
  // }


  isDark ??= false;

  runApp( MyApp(
    isDark: isDark,
    // startWidget: widget,
  ));
}

class MyApp extends StatelessWidget
{

  final bool? isDark;
  final Widget? startWidget;
  final String? token = CacheHelper.getData(key: 'token');

  MyApp({
    super.key,
    this.isDark,
    this.startWidget,

  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      SocialCubit(token: token)
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        // // //themeMode: ShopCubit.get(context).isDark
        // //     ? ThemeMode.dark
        // //     : ThemeMode.light,
        home: SocialLoginScreen(),
      ),
    );
  }
}
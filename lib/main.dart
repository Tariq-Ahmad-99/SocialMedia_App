import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peki_media/layout/social_layout.dart';
import 'package:peki_media/modules/social_login/social_login_screen.dart';
import 'package:peki_media/shared/Bloc_observer.dart';
import 'package:peki_media/shared/components/components.dart';
import 'package:peki_media/shared/components/contents.dart';
import 'package:peki_media/shared/network/local/cache_helper.dart';
import 'package:peki_media/shared/network/remote/dio_helper.dart';
import 'package:peki_media/shared/styles/themes.dart';
import 'layout/social_cubit/social_cubit.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  print(message.data.toString());

  showToast(
      text: 'on background message',
      state: ToastStates.success,
  );
}

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Rest of your main function
  var token = await FirebaseMessaging.instance.getToken();

  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print('onMessage');
    print(event.data.toString());

    showToast(
      text: 'onMessage',
      state: ToastStates.success,
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());

    showToast(
      text: 'onMessage opened app',
      state: ToastStates.success,
    );
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool? isDark = CacheHelper.getData(key: 'isDark');
  //String? token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId')?? '';

  if (uId.isNotEmpty) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  isDark ??= false;

  runApp( MyApp(
    isDark: isDark,
    startWidget: widget,
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
      SocialCubit()..getUserData()..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: startWidget,
      ),
    );
  }
}
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peki_media/layout/social_cubit/social_state.dart';
import 'package:peki_media/models/user_model.dart';
import 'package:peki_media/modules/chats/chats_screen.dart';
import 'package:peki_media/modules/feeds/feeds_screen.dart';
import 'package:peki_media/modules/settings/settings_screen.dart';
import 'package:peki_media/modules/users/users_screen.dart';

import '../../shared/components/contents.dart';

class SocialCubit extends Cubit<SocialState>
{
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          //print(value.data());
          model = SocialUserModel.fromJson(value.data()!);
          emit(SocialGetUserSuccessState());
    })
        .catchError((error) {
          print(error.toString());
          emit(SocialGetUserErrorState(error.toString()));
    });

  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index)
  {

    if(index == 2)
      emit(SocialNewPostState());
    else
    {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }

  }

}

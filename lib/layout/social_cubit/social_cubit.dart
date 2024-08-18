import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peki_media/layout/social_cubit/social_state.dart';
import 'package:peki_media/models/user_model.dart';
import 'package:peki_media/modules/New_Post/new_post_screen.dart';
import 'package:peki_media/modules/chats/chats_screen.dart';
import 'package:peki_media/modules/feeds/feeds_screen.dart';
import 'package:peki_media/modules/settings/settings_screen.dart';
import 'package:peki_media/modules/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared/components/contents.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      //print(value.data());
      userModel = SocialUserModel.fromJson(value.data()!);
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
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  File? coverImage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,})
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref.getDownloadURL().then((value)
          {
            //emit(SocialUploadProfileImageSuccessState());
            print(value);
            updateUser(
              name: name,
              phone: phone,
              bio: bio,
              image: value,
            );
          }).catchError((error){
            emit(SocialUploadProfileImageErrorState());
          });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }


  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,})
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value)
      {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error){
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }
//
//   void updateUserImages({
//     required String name,
//     required String phone,
//     required String bio,
// }){
//     emit(SocialUserUpdateLoadingState());
//     if(coverImage != null)
//     {
//       uploadCoverImage();
//     } else if(profileImage != null)
//     {
//       uploadProfileImage();
//     } else if(coverImage != null && profileImage != null)
//     {
//
//     } else
//     {
//       updateUser(
//         name: name,
//         phone: phone,
//         bio: bio,
//       );
//     }
//   }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  })
  {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      cover: cover??userModel!.cover,
      image: image??userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value)
    {
      getUserData();
    })
        .catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }
}

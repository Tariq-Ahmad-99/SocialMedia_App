
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peki_media/models/user_model.dart';
import 'package:peki_media/modules/social_register/cubit/states.dart';



class SocialRegisterCubit extends Cubit<SocialRegisterState>{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  // SocialLoginModel? loginModel;


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    )
        .then((value) {
          print(value.user?.email);
          print(value.user?.uid);
          userCreate(
              name: name,
              email: email,
              uId: value.user!.uid,
              phone: phone,
          );
    })
        .catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate(
  {
    required String name,
    required String email,
    required String uId,
    required String phone,
  })
  {

    SocialUserModel model = SocialUserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value)
    {
          emit(SocialCreateUserSuccessState());
    })
        .catchError((error)
    {
          emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined:  Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
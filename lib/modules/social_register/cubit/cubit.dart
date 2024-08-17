
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
        image: 'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?t=st=1722851984~exp=1722855584~hmac=7954e6761b8cc23123b6a25e050c3ba47ec2eaddc90aba540ca3cde9c6216af2&w=740',
        cover: 'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?t=st=1722851984~exp=1722855584~hmac=7954e6761b8cc23123b6a25e050c3ba47ec2eaddc90aba540ca3cde9c6216af2&w=740',
        bio: 'write you bio ...',
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
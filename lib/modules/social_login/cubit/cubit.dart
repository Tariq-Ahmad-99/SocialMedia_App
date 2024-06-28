import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peki_media/modules/social_login/cubit/states.dart';


class SocialLoginCubit extends Cubit<SocialLoginState>{
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  // SocialLoginModel? loginModel;


  // void userLogin({
  //   required String email,
  //   required String password,
  // })
  // {
  //   emit(SocialLoginLoadingState());
  //   DioHelper.postData(
  //     url: LOGIN,
  //     data:
  //     {
  //       'email':email,
  //       'password':password,
  //     },
  //
  //   ).then((value) {
  //     loginModel = SocialLoginModel.fromJson(value.data);
  //     emit(SocialLoginSuccessState(loginModel!));
  //   }).catchError((error){
  //     emit(SocialLoginErrorState(error.toString()));
  //   });
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined:  Icons.visibility_off_outlined;

    emit(SocialChangePasswordVisibilityState());
  }
}
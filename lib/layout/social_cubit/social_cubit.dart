

// class SocialCubit extends Cubit<SocialState>
// {
//   SocialCubit(super.initialState);
//
//   static get(context) {}
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peki_media/layout/social_cubit/social_state.dart';

import '../../models/home_model.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';


class SocialCubit extends Cubit<SocialState>
{
  final String? token;
  SocialCubit({this.token}) : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    // const ProductsScreen(),
    // const CategoriesScreen(),
    // const FavoritesScreen(),
    // SettingScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};


  void getHomeData()
  {
    emit(SocialLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element)
      {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      emit(SocialSuccessHomeDataState());
    }).catchError((error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialErrorHomeDataState());
    });
  }


  // CategoriesModel? categoriesModel;

  void getCategories()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      // categoriesModel = CategoriesModel.fromJson(value.data);

      emit(SocialSuccessCategoriesState());
    }).catchError((error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialErrorCategoriesState());
    });
  }

  // ChangeFavoritesModel? changeFavoritesModel;


  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(SocialSuccessChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {

      // changeFavoritesModel != null ?  ChangeFavoritesModel.fromJson(value.data) : null;
      //
      // if(changeFavoritesModel?.status == false)
      // {
      //   favorites[productId] = !favorites[productId]!;
      // }else
      // {
      //   getFavorites();
      // }


      emit(SocialSuccessChangeFavoritesState());
    }).catchError((error)
    {
      emit(SocialErrorChangeFavoritesState());
    });
  }


  // FavoritesModel? favoritesModel;

  void getFavorites()
  {
    emit(SocialLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      // favoritesModel = FavoritesModel.fromJson(value.data);

      emit(SocialSuccessGetFavoritesState());
    }).catchError((error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialErrorGetFavoritesState());
    });
  }


  // SocialLoginModel? userModel;


  void getUserData() {
    print('getUserData() called');
    emit(SocialLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      final responseData = value.data;

      if (responseData['status'] == true) {
        // userModel = SocialLoginModel.fromJson(responseData);
        //
        // emit(SocialSuccessUserDataState(userModel!));
      } else {
        // emit(SocialErrorUserDataState());
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  })
  {
    emit(SocialLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      final responseData = value.data;

      if (responseData['status'] == true) {
        // userModel = SocialLoginModel.fromJson(responseData);
        //
        // emit(SocialSuccessUpdateUserState(userModel!));
      } else {
        // emit(SocialErrorUpdateUserState());
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialErrorUpdateUserState());
    });
  }


}
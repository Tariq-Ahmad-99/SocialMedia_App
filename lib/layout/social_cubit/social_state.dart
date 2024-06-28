

abstract class SocialState {}

class SocialInitialState extends SocialState{}

class SocialChangeBottomNavState extends SocialState {}


class SocialLoadingHomeDataState extends SocialState{}
class SocialSuccessHomeDataState extends SocialState{}
class SocialErrorHomeDataState extends SocialState{}


class SocialSuccessCategoriesState extends SocialState{}
class SocialErrorCategoriesState extends SocialState{}

class SocialSuccessChangeFavoritesState extends SocialState
{
}
class SocialChangeFavoritesState extends SocialState{}
class SocialErrorChangeFavoritesState extends SocialState{}


class SocialSuccessGetFavoritesState extends SocialState{}
class SocialLoadingGetFavoritesState extends SocialState{}
class SocialErrorGetFavoritesState extends SocialState{}


class SocialLoadingUserDataState extends SocialState {}
class SocialSuccessUserDataState extends SocialState
{
  // final SocialLoginModel loginModel;
  //
  // SocialSuccessUserDataState(this.loginModel);
}
class SocialErrorUserDataState extends SocialState{}

class SocialLoadingUpdateUserState extends SocialState {}
class SocialSuccessUpdateUserState extends SocialState
{
  // final SocialLoginModel loginModel;
  //
  // SocialSuccessUpdateUserState(this.loginModel);
}
class SocialErrorUpdateUserState extends SocialState{}

abstract class SocialState {}

class SocialInitialState extends SocialState{}

//GET User Data
class SocialGetUserLoadingState extends SocialState{}
class SocialGetUserSuccessState extends SocialState{}
class SocialGetUserErrorState extends SocialState
{
  final String error;

  SocialGetUserErrorState(this.error);
}

//GET Posts
class SocialGetPostsLoadingState extends SocialState{}
class SocialGetPostsSuccessState extends SocialState{}
class SocialGetPostsErrorState extends SocialState
{
  final String error;

  SocialGetPostsErrorState(this.error);
}

//GET Likes
class SocialLikePostSuccessState extends SocialState{}
class SocialLikePostErrorState extends SocialState
{
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialState {}

class SocialNewPostState extends SocialState {}

//Picking And Uploading Images
class SocialProfileImagePickedSuccessState extends SocialState {}
class SocialProfileImagePickedErrorState extends SocialState {}

class SocialCoverImagePickedSuccessState extends SocialState {}
class SocialCoverImagePickedErrorState extends SocialState {}

class SocialUploadProfileImageSuccessState extends SocialState {}
class SocialUploadProfileImageErrorState extends SocialState {}

class SocialUploadCoverImageSuccessState extends SocialState {}
class SocialUploadCoverImageErrorState extends SocialState {}

//User Update
class SocialUserUpdateLoadingState extends SocialState {}
class SocialUserUpdateErrorState extends SocialState {}

//Create Post
class SocialCreatePostLoadingState extends SocialState {}
class SocialCreatePostSuccessState extends SocialState {}
class SocialCreatePostErrorState extends SocialState {}

class SocialPostImagePickedSuccessState extends SocialState {}
class SocialPostImagePickedErrorState extends SocialState {}

class SocialRemovePostImageState extends SocialState {}
abstract class SocialState {}

class SocialInitialState extends SocialState {}

class SocialGetUserLoadingState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUserLoadingState extends SocialState {}

class SocialGetAllUserSuccessState extends SocialState {}

class SocialGetAllUserErrorState extends SocialState {
  final String error;

  SocialGetAllUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialState {}

class SocialNewPatState extends SocialState {}

class SocialProfileImagePickedSuccessState extends SocialState {}

class SocialProfileImagePickedErrorState extends SocialState {}

class SocialUploadProfileImagePickedSuccessState extends SocialState {}

class SocialUploadProfileImagePickedLoadingState extends SocialState {}

class SocialUploadProfileImagePickedErrorState extends SocialState {}

class SocialUpdateUserDateErrorState extends SocialState {}

class SocialCreatePostLoadingState extends SocialState {}

class SocialCreatePostSuccessState extends SocialState {}

class SocialCreatePostErrorState extends SocialState {}

class SocialPostImagePickedSuccessState extends SocialState {}

class SocialPostImagePickedErrorState extends SocialState {}

class SocialRemovePostImageState extends SocialState {}

class SocialGetPostsLoadingState extends SocialState {}

class SocialGetPostsSuccessState extends SocialState {}

class SocialGetPostsErrorState extends SocialState {
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialState {}

class SocialLikePostErrorState extends SocialState {
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialChangeState extends SocialState {}

class SocialUnChangeState extends SocialState {}

class SocialSendMessageSuccessState extends SocialState {}

class SocialSendMessageErrorState extends SocialState {}

class SocialGetMessageSuccessState extends SocialState {}

class SocialGetMessageErrorState extends SocialState {}

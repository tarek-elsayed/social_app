abstract class SocialState {}

class SocialInitialState extends SocialState {}

class SocialGetUserLoadingState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialState {}

class SocialNewPatState extends SocialState {}

class SocialProfileImagePickedSuccessState extends SocialState {}

class SocialProfileImagePickedErrorState extends SocialState {}

class SocialUploadProfileImagePickedSuccessState extends SocialState {}
class SocialUploadProfileImagePickedLoadingState extends SocialState {}

class SocialUploadProfileImagePickedErrorState extends SocialState {}
class SocialUpdateUserDateErrorState extends SocialState {}


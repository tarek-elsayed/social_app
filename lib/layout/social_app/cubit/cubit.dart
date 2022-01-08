import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/layout/social_app/cubit/state.dart';
import 'package:social_app/model/social_model/social_user_model.dart';
import 'package:social_app/modules/social_app/add_post/add_post.dart';
import 'package:social_app/modules/social_app/chats/chats_screen.dart';
import 'package:social_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:social_app/modules/social_app/setting/setting_screen.dart';
import 'package:social_app/modules/social_app/users/users_screen.dart';
import 'package:social_app/shared/components/constains.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel model;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection("user").doc(uId).get().then((value) {
      print(value.data());
      model = UserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
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
    SettingScreen(),
  ];
  List<String> titles = [
    "News Feeds",
    "Chats",
    "Posts",
    "Users",
    "Settings",

  ];

  void changeBottomNav(int index) {
    print(index);
    if (index == 2) {
      emit(SocialNewPatState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File profileImage;
  var piker = ImagePicker();

  Future getProfileImage() async {
    final pikedImage = await piker.pickImage(source: ImageSource.camera);
    if (pikedImage != null) {
      profileImage = File(pikedImage.path);
      emit(SocialProfileImagePickedSuccessState());
      uploadProfileImage();
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  String profileImageUrl = '';

  void uploadProfileImage() {
    emit(SocialUploadProfileImagePickedLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('UserImage/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        emit(SocialUploadProfileImagePickedSuccessState());
      });
    }).catchError((error) {
      print("eee${error.toString()}");
      emit(SocialUploadProfileImagePickedErrorState());
    });
  }

  void updateUserDate({
    @required String phone,
    @required String name,
    @required String bio,
  }) {
    print('tarek ${profileImage.toString()}');
    if (profileImage != null) {
      UserModel userModel = UserModel(
        email: model.email,
        phone: phone,
        bio: bio,
        name: name,
        uId: uId,
        image: profileImageUrl,
        isEmailVerified: model.isEmailVerified,
      );
      FirebaseFirestore.instance
          .collection('user')
          .doc(uId)
          .update(userModel.toMap())
          .then((value) {
        print('selected');
        getUserData();
      }).catchError((error) {
        emit(SocialUpdateUserDateErrorState());
      });
    } else {
      UserModel userModel = UserModel(
        email: model.email,
        phone: phone,
        bio: bio,
        name: name,
        uId: uId,
        image: model.image,
        isEmailVerified: model.isEmailVerified,
      );
      FirebaseFirestore.instance
          .collection('user')
          .doc(uId)
          .update(userModel.toMap())
          .then((value) {
        print('not selected');
        getUserData();
      }).catchError((error) {
        emit(SocialUpdateUserDateErrorState());
      });
    }
  }
}

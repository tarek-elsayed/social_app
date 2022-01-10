import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/layout/social_app/cubit/state.dart';
import 'package:social_app/model/message_model/message_model.dart';
import 'package:social_app/model/post_model/post_model.dart';
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
    if (index == 1) {
      getUsers();
    }
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

  File postImage;

  Future getPostImage() async {
    final pikedImage = await piker.pickImage(
      source: ImageSource.gallery,
    );
    if (pikedImage != null) {
      postImage = File(pikedImage.path);
      emit(SocialPostImagePickedSuccessState());
      uploadProfileImage();
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    @required String dateTime,
    @required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('UserImage/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialCreatePostSuccessState());
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialPostImagePickedErrorState());
      });
    }).catchError((error) {
      print("eee${error.toString()}");
      emit(SocialPostImagePickedErrorState());
    });
  }

  void createPost({
    @required String dateTime,
    @required String text,
    String postImage,
  }) {
    print('tarek ${profileImage.toString()}');
    emit(SocialCreatePostLoadingState());
    PostModel postModel = PostModel(
      name: model.name,
      uId: model.uId,
      image: model.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? "",
    );
    FirebaseFirestore.instance
        .collection('post')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<int> comment = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection("post").get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comment').get().then((value) {
          comment.add(value.docs.length);
          element.reference.collection('likes').get().then((value) {
            likes.add(value.docs.length);
            postId.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
          }).catchError((error) {});
        }).catchError((error) {});
      });
      print(posts[0].text);
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection("post")
        .doc(postId)
        .collection("likes")
        .doc(model.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void commentPost(String postId, String text) {
    FirebaseFirestore.instance
        .collection("post")
        .doc(postId)
        .collection("comment")
        .doc(model.uId)
        .set({'comment': text}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  int x;

  void change(int index) {
    x = index;
    emit(SocialChangeState());
  }

  void unChange(int index) {
    x = index;
    emit(SocialUnChangeState());
  }

  List<UserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('user').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetUserSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUserErrorState(error.toString()));
      });
  }

  void sendMessage({
    @required String receiverId,
    @required String dateTime,
    @required String text,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: uId,
    );

    //set my chat

    FirebaseFirestore.instance
        .collection("user")
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    //set receiver chat

    FirebaseFirestore.instance
        .collection("user")
        .doc(receiverId)
        .collection('chats')
        .doc(model.uId)
        .collection('message')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    @required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }
}

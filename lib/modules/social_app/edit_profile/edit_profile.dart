import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_app/cubit/state.dart';
import 'package:social_app/shared/components/components.dart';


class EditProfileScreen extends StatelessWidget {
  var name = TextEditingController();
  var bio = TextEditingController();
  var phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        var profileImage = SocialCubit.get(context).profileImage;

        name.text = userModel.name;
        bio.text = userModel.bio;
        phone.text = userModel.phone;
        return Scaffold(
          appBar: defaultAppBar(context: context, title: 'Add Post', actions: [
            defaultTextButton(
              text: 'Update',
              function: () {
                SocialCubit.get(context).updateUserDate(
                    phone: phone.text, name: name.text, bio: bio.text);
              },
            ),
            SizedBox(
              width: 10.0,
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUploadProfileImagePickedLoadingState||state is SocialGetUserLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 200.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Container(
                            height: 140.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://image.freepik.com/free-photo/portrait-beautiful-young-woman-gesticulating_273609-41056.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage),
                              ),
                            ),
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: Icon(Icons.camera_alt),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  defaultFormField(
                    controller: name,
                    type: TextInputType.name,
                    validation: (String value) {
                      if (value.isEmpty) {
                        return "Name must not be empty";
                      }
                      return null;
                    },
                    labelText: "Name",
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: phone,
                    type: TextInputType.name,
                    validation: (String value) {
                      if (value.isEmpty) {
                        return "Phone must not be empty";
                      }
                      return null;
                    },
                    labelText: "Name",
                    prefix: Icons.phone_android,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: bio,
                    type: TextInputType.text,
                    validation: (String value) {
                      if (value.isEmpty) {
                        return "Bio must not be empty";
                      }
                      return null;
                    },
                    labelText: "Bio",
                    prefix: Icons.info,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

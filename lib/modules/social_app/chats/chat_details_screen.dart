import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_app/cubit/state.dart';
import 'package:social_app/model/social_model/social_user_model.dart';
import 'package:social_app/shared/styles/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;

  ChatDetailsScreen({
    this.userModel,
  });

  var message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(userModel.image),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  userModel.name,
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(10),
                        topStart: Radius.circular(10),
                        topEnd: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10.0),
                    child: const Text(
                      'Hello World',
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    decoration: BoxDecoration(
                      color: defaultColor.withOpacity(.4),
                      borderRadius: BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(10),
                        topStart: Radius.circular(10),
                        topEnd: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10.0),
                    child: const Text(
                      'Hello World',
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300],
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: message,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "type your message here ..."),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        color: defaultColor,
                        child: MaterialButton(
                          minWidth: 1.0,
                          onPressed: () {
                            SocialCubit.get(context).sendMessage(
                              receiverId: userModel.uId,
                              dateTime: DateTime.now().toString(),
                              text: message.text,
                            );
                          },
                          child: Icon(
                            Icons.send_rounded,
                            size: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

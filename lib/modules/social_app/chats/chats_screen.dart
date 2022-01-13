import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_app/cubit/state.dart';
import 'package:social_app/model/social_model/social_user_model.dart';
import 'package:social_app/modules/social_app/chats/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.users.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: cubit.users.length,
            itemBuilder: (context, index) {
              return buildChatItem(cubit.users[index],context);
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 8.0,
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model,context) => InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(userModel: model,));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  "${model.image}",
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '${model.name}',
                style: TextStyle(height: 1.0),
              ),
            ],
          ),
        ),
      );
}

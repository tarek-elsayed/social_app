import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_app/cubit/state.dart';
import 'package:social_app/model/post_model/post_model.dart';
import 'package:social_app/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  var comment =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: (SocialCubit.get(context).posts.length > 0 &&
                SocialCubit.get(context).model != null)&& SocialCubit.get(context).comment.length > 0,
            builder: (context) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Card(
                    //   clipBehavior: Clip.antiAliasWithSaveLayer,
                    //   elevation: 10.0,
                    //   margin: EdgeInsets.all(8.0),
                    //   child: Stack(
                    //     alignment: AlignmentDirectional.bottomEnd,
                    //     children: [
                    //       Image(
                    //         image: NetworkImage(
                    //             "https://image.freepik.com/free-photo/portrait-beautiful-young-woman-gesticulating_273609-41056.jpg"),
                    //         fit: BoxFit.cover,
                    //         height: 200.0,
                    //         width: double.infinity,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Text(
                    //           'communication with friends',
                    //           style: Theme.of(context).textTheme.subtitle1,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(
                          SocialCubit.get(context).posts[index],
                          context,
                          index,
                          state),
                      itemCount: SocialCubit.get(context).posts.length,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildPostItem(PostModel model, context, index, state) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                      "${SocialCubit.get(context).model.image}")),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: TextStyle(height: 1.0),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          size: 15,
                          color: defaultColor,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz,
                  size: 18.0,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Container(
                    height: 25.0,
                    child: MaterialButton(
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Text(
                        '#Software',
                        style: TextStyle(color: defaultColor),
                      ),
                    ),
                  ),
                  Container(
                    height: 25.0,
                    child: MaterialButton(
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Text(
                        '#JavaScript',
                        style: TextStyle(color: defaultColor),
                      ),
                    ),
                  ),
                  Container(
                    height: 25.0,
                    child: MaterialButton(
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Text(
                        '#Dart',
                        style: TextStyle(color: defaultColor),
                      ),
                    ),
                  ),
                  Container(
                    height: 25.0,
                    child: MaterialButton(
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Text(
                        '#flutter',
                        style: TextStyle(color: defaultColor),
                      ),
                    ),
                  ),
                  Container(
                    height: 25.0,
                    child: MaterialButton(
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Text(
                        '#CSS',
                        style: TextStyle(color: defaultColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (model.postImage != "")
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 15.0),
              child: Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      "${model.postImage}",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_outline,
                          size: 18,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${SocialCubit.get(context).likes[index]}',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.message_outlined,
                          size: 18,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${SocialCubit.get(context).comment[index]} comment',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18.0,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).model.image}'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: TextField(
                        controller: comment,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Write a comment.."),
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            SocialCubit.get(context).change(index);
                          }
                          if (val.length == 0) {
                            SocialCubit.get(context).unChange(index);
                          }
                        },
                        // onTap: () {
                        //   SocialCubit.get(context).change(index);
                        // },
                      ),
                    ),
                  ],
                ),
              ),
              state is SocialChangeState ? IconButton(
                onPressed: (){
                  SocialCubit.get(context)
                      .commentPost(SocialCubit.get(context).postId[index],comment.text);
                },
                icon: Icon(Icons.send),
              ): InkWell(
                onTap: () {
                  SocialCubit.get(context)
                      .likePost(SocialCubit.get(context).postId[index]);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite_outline,
                      size: 18,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

}
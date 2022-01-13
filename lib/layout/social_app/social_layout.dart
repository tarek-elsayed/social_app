import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_app/cubit/state.dart';
import 'package:social_app/modules/social_app/add_post/add_post.dart';
import 'package:social_app/modules/social_app/login/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';


class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if(state is SocialNewPatState){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: (){
          //     CacheHelper.removeData(key: 'uId');
          //     navigateTo(context, LoginScreen());
          //   },
          //   child: Icon(Icons.logout),
          // ),
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 25.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            // selectedItemColor: Colors.black,
            // unselectedItemColor: Colors.white,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Chats',
                icon: Icon(Icons.chat_bubble),
              ),
              BottomNavigationBarItem(
                label: 'Add Post',
                icon: Icon(Icons.add_box_outlined),
              ),

              BottomNavigationBarItem(
                label: 'Users',
                icon: Icon(Icons.location_on),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peki_media/layout/social_cubit/social_cubit.dart';
import 'package:peki_media/layout/social_cubit/social_state.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:peki_media/modules/New_Post/new_post_screen.dart';
import 'package:peki_media/shared/components/components.dart';


class SocialLayout extends StatelessWidget
{
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state)
      {
        if(state is SocialNewPostState)
        {
          navigateTo(
            context,
            NewPostScreen(),
          );
        }
      },
      builder: (context, state)
      {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: (){},
                icon: Icon(
                  EvaIcons.bellOutline,
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(
                  EvaIcons.searchOutline,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            items: 
            const [
              BottomNavigationBarItem(
                  icon: Icon(
                    EvaIcons.home,
                  ),
                  label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.messageSquare,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.post_add_outlined,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.people,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

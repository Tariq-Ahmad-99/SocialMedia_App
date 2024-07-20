import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peki_media/layout/social_cubit/social_cubit.dart';
import 'package:peki_media/layout/social_cubit/social_state.dart';
import 'package:peki_media/shared/components/components.dart';

class SocialLayout extends StatelessWidget
{
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News Feed',
            ),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).model != null,
            builder: (context)
            {
              var model = FirebaseAuth.instance.currentUser!.emailVerified;
              print(model);

              return Column(
                children:
                [
                  if(!model)
                  Container(
                    color: Colors.amber.withOpacity(.6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Row(
                        children:
                        [
                          Icon(
                            Icons.info_outline,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Text(
                              'please verify your email',
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          defaultTextButton(
                            function: ()
                            {
                              FirebaseAuth.instance.currentUser?.sendEmailVerification()
                                  .then((value) 
                              {
                                showToast(
                                    text: 'Check Your Mail',
                                    state: ToastStates.success,
                                );
                              })
                                  .catchError((error) {});
                            },
                            text: 'send',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

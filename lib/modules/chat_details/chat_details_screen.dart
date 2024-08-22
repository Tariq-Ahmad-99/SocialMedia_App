import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peki_media/layout/social_cubit/social_cubit.dart';
import 'package:peki_media/layout/social_cubit/social_state.dart';
import 'package:peki_media/models/message_model.dart';
import 'package:peki_media/models/user_model.dart';
import 'package:peki_media/shared/styles/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;

  ChatDetailsScreen({
    super.key,
    required this.userModel,
  });

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessage(
          receiverId: userModel.uId,
        );
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
                      backgroundImage: NetworkImage(
                        '${userModel.image}',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      '${userModel.name}',
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: state is! SocialGetMessageLoadingState,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children:
                    [
                      if (SocialCubit.get(context).messages.isNotEmpty)
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message = SocialCubit.get(context).messages[index];
                              if (SocialCubit.get(context).userModel?.uId == message.senderId)
                                return buildMyMessage(message);
                              return buildMessage(message);
                            },
                            separatorBuilder: (context, state) => SizedBox(
                              height: 15.0,
                            ),
                            itemCount: SocialCubit.get(context).messages.length,
                          ),
                        )
                      else
                        Expanded(
                          child: Center(
                            child: Text(
                              "No messages yet. Start the conversation!",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type your message here ...',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: userModel.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                  messageController.clear();
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  Icons.send_sharp,
                                  size: 16.0,
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
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        '${model.text}',
      ),
    ),
  );

  Widget buildMyMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        color: defaultColor.withOpacity(
          .2,
        ),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        '${model.text}',
      ),
    ),
  );
}

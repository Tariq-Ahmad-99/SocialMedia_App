import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peki_media/layout/social_cubit/social_cubit.dart';
import 'package:peki_media/layout/social_cubit/social_state.dart';
import '../../shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                function: () {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                  );
                },
                text: 'Update',
              ),
              SizedBox(
                width: 15.0,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                    SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage) as ImageProvider<Object> ,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 18.0,
                                  child: Icon(
                                    EvaIcons.cameraOutline,
                                    color: Colors.white,
                                    size: 22.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage)
                                        as ImageProvider<Object>,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 18.0,
                                child: Icon(
                                  EvaIcons.cameraOutline,
                                  color: Colors.white,
                                  size: 22.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                    Row(
                    children: [
                      if(SocialCubit.get(context).profileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                text: 'upload profile',
                                function: ()
                                {
                                  SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                  );
                                },
                              ),
                              if(state is SocialUserUpdateLoadingState)
                                SizedBox(
                                  height: 5.0,
                                ),
                              if(state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if(SocialCubit.get(context).coverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                text: 'upload cover',
                                function: ()
                                {
                                  SocialCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                              ),
                              if(state is SocialUserUpdateLoadingState)
                                SizedBox(
                                  height: 5.0,
                                ),
                              if(state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                    ],
                  ),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                    SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: EvaIcons.peopleOutline,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix: EvaIcons.infoOutline,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'phone number must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: EvaIcons.phoneCallOutline,
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

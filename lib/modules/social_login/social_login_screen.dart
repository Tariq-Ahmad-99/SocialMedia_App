import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../social_register/social_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (context, state)
        {
          if(state is SocialLoginErrorState){
            showToast(
                text: state.error,
                state: ToastStates.error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'login now to communicate with your friends',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30.0,),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(height: 15.0,),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: SocialLoginCubit.get(context).suffix,
                          onSubmit: (value)
                          {
                            if (formKey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            SocialLoginCubit.get(context).changePasswordVisibility();
                          },
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'password is to short';
                            }
                            return null;
                          },
                          label: 'password',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(height: 30.0,),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: ()
                            {
                              if (formKey.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                            radius: 20.0,
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },
                              text: 'Register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

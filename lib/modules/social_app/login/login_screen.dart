import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/social_layout.dart';
import 'package:social_app/modules/social_app/login/cubit/cubit.dart';
import 'package:social_app/modules/social_app/login/cubit/states.dart';
import 'package:social_app/modules/social_app/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';


class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              text: state.error,
              state: ToastState.ERROR,
            );
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: "uId", value: state.uId).then((value) {
              navigateAndFinish(
                context,
                SocialLayout(),
              );
            });
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline3.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        'Login now to communicate with friend',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.blueGrey,
                            ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: email,
                        type: TextInputType.emailAddress,
                        validation: (String value) {
                          if (value.isEmpty) {
                            return "Please enter your email";
                          }
                        },
                        labelText: "Email Address",
                        prefix: Icons.email_outlined,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controller: password,
                        type: TextInputType.visiblePassword,
                        validation: (String value) {
                          if (value.isEmpty) {
                            return "Please enter your password";
                          }
                        },
                        suffixIcon: Icons.visibility,
                        onSubmit: (value) {
                          if (formKey.currentState.validate()) {
                            // SocialLoginCubit.get(context).userLogin(
                            //   email: email.text,
                            //   password: password.text,
                            // );
                          }
                        },
                        obscureText:
                            SocialLoginCubit.get(context).isPasswordShown,
                        suffixIconPress: () {
                          SocialLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        labelText: "Password",
                        prefix: Icons.lock_outline,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialLoginLoadingState,
                        builder: (context) => defaultButton(
                          text: "Login",
                          function: () {
                            if (formKey.currentState.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                email: email.text,
                                password: password.text,
                              );
                            }
                          },
                          isUpperCase: true,
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          defaultTextButton(
                            function: () {
                              navigateTo(context, SocialRegisterScreen());
                            },
                            text: 'Sign Up',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

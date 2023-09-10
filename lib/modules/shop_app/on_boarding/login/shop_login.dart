import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/shop_app/on_boarding/login/cubit/cubit.dart';
import 'package:flutter_application_1/modules/shop_app/on_boarding/login/cubit/states.dart';
import 'package:flutter_application_1/modules/shop_app/register/shop_register_screen.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/network/local/cach_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../layout/shop_app/shop_layout.dart';
import '../../../../shared/components/constants.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if (state is ShopLoginSuccessState) {
              if (state.modle.status == true) {
                print(state.modle.message);
                CachHelper.saveData(
                        key: 'token', value: state.modle.data!.token)
                    .then((value) {
                  token = state.modle.data!.token!;
                  showToast(
                      message: state.modle.message as String,
                      state: ToastState.SUCCESS);
                  NavigatorAndFinish(context, ShopLayout());
                });
              } else {
                print(state.modle.message);

                showToast(
                    message: state.modle.message as String,
                    state: ToastState.ERROR);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Login now to browse our hot offers",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormfiled(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Emil Address',
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter email address';
                              }
                            },
                            prefix: Icons.email_outlined),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormfiled(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: 'password',
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            prefix: Icons.lock_outline,
                            suffix: ShopLoginCubit().get(context).suffix,
                            ispassword:
                                ShopLoginCubit().get(context).ispassword,
                            onSubmit: (value) {
                              if (formkey.currentState!.validate()) {
                                ShopLoginCubit().get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            suffixpressed: () {
                              ShopLoginCubit()
                                  .get(context)
                                  .changePasswordVisiblity();
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formkey.currentState!.validate()) {
                                    ShopLoginCubit().get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: "LOGIN"),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator())),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("don\'t have an account?"),
                            defaultTextButton(
                                function: () {
                                  NavigatorAndFinish(
                                      context, ShopregisterScreen());
                                },
                                text: 'register now')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}

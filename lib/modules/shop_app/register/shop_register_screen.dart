import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/shop_app/register/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cach_helper.dart';
import '../on_boarding/login/cubit/cubit.dart';
import '../on_boarding/login/cubit/states.dart';
import 'cubit/states.dart';

class ShopregisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.modle.status == true) {
              print(state.modle.message);
              CachHelper.saveData(key: 'token', value: state.modle.data!.token)
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
          return Center(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "register now to browse our hot offers",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormfiled(
                        controller: nameController,
                        type: TextInputType.name,
                        label: 'name',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'please enter name';
                          }
                        },
                        prefix: Icons.person),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormfiled(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Email Address',
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
                        suffix: ShopRegisterCubit().get(context).suffix,
                        ispassword: ShopRegisterCubit().get(context).ispassword,
                        onSubmit: (value) {
                          if (formkey.currentState!.validate()) {
                            ShopRegisterCubit().get(context).userRegister(
                                email: emailController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                                password: passwordController.text);
                          }
                        },
                        suffixpressed: () {
                          ShopRegisterCubit()
                              .get(context)
                              .changePasswordVisiblity();
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormfiled(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'phone',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'please enter phone';
                          }
                        },
                        prefix: Icons.phone),
                    SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopRegisterLoadingState,
                      builder: (context) => defaultButton(
                          function: () {
                            if (formkey.currentState!.validate()) {
                              ShopRegisterCubit().get(context).userRegister(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: 'REGISTER'),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

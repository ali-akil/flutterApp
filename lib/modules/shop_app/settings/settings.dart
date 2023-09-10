import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/states.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopeSuccessUpdateDataState) {
          showToast(
              message: ShopCubit.get(context).profileUserModel!.message!,
              state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        var usermodel = ShopCubit.get(context).profileUserModel;
        if (usermodel != null) {
          nameController.text = usermodel.data!.name!;
          emailController.text = usermodel.data!.email!;
          phoneController.text = usermodel.data!.phone!;
        }
        return ConditionalBuilder(
          condition: ShopCubit.get(context).profileUserModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  defaultFormfiled(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'user name',
                      validate: (value) {
                        if (value.isEmpty) {
                          return ' name must not be empty';
                        }
                        return null;
                      },
                      prefix: Icons.person),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormfiled(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email',
                      validate: (value) {
                        if (value.isEmpty) {
                          return ' Email must not be empty';
                        }
                        return null;
                      },
                      prefix: Icons.email_outlined),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormfiled(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone',
                      validate: (value) {
                        if (value.isEmpty) {
                          return ' Phone must not be empty';
                        }
                        return null;
                      },
                      prefix: Icons.phone),
                  SizedBox(
                    height: 20,
                  ),
                  ConditionalBuilder(
                    condition: state is! ShopeLoadingUpdateDataState,
                    builder: (context) => defaultButton(
                        function: () {
                          if (formkey.currentState!.validate()) {
                            ShopCubit.get(context).updateData(
                              email: emailController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: 'UPDATE'),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: 'LOGOUT')
                ],
              ),
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

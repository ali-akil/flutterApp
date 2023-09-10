import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shop_app/login_model.dart';
import 'package:flutter_application_1/modules/shop_app/on_boarding/login/cubit/states.dart';
import 'package:flutter_application_1/modules/shop_app/register/cubit/states.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModle? registerModle;
  void userRegister(
      {required String name,
      required String email,
      required String phone,
      required String password}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name
    }).then((value) {
      registerModle = ShopLoginModle.Fromjson(value.data);

      emit(ShopRegisterSuccessState(registerModle!));
    }).catchError((error) {
      print(error);
      emit(ShopRegisterErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispassword = true;
  void changePasswordVisiblity() {
    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    ispassword = !ispassword;
    emit(ShopChangePasswordRegisterVisiblityState());
  }
}

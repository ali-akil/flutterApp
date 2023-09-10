import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shop_app/login_model.dart';
import 'package:flutter_application_1/modules/shop_app/on_boarding/login/cubit/states.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModle? loginModle;
  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      loginModle = ShopLoginModle.Fromjson(value.data);

      emit(ShopLoginSuccessState(loginModle!));
    }).catchError((error) {
      print(error);
      emit(ShopLoginErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispassword = true;
  void changePasswordVisiblity() {
    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    ispassword = !ispassword;
    emit(ShopChangePasswordVisiblityState());
  }
}

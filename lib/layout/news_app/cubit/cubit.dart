import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/news_app/cubit/states.dart';

import 'package:flutter_application_1/shared/network/local/cach_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  int cureentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void ChangeBottonNavBar(index) {
    cureentIndex = index;
    emit(NewButtomNavState());
  }

  static NewsCubit get(context) {
    return BlocProvider.of(context);
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewGetBusinessLoadingState());
    // DioHelper.getData(url: 'v2/top-headlines', qurey: {
    //   'country': 'eg ',
    //   'category': 'business',
    //   'apikey': '65f7f556ec76449fa7dc7c0069f040ca'
    // }).then((value) {
    //   //print(value.data.toString());
    //   business = value.data['articles'];
    //   //print(business[0]);
    //   emit(NewGetBusinessSuccessState());
    // }).catchError((error) {
    //   print(error.toString());
    //emit(NewGetBusinessErrorState(error.toString()));
    // });
  }

  List<dynamic> sport = [];
  void getSport() {
    emit(NewGetsportLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', qurey: {
      'country': 'eg ',
      'category': 'business',
      'apikey': '65f7f556ec76449fa7dc7c0069f040ca'
    }).then((value) {
      //print(value.data.toString());
      science = value.data['articles'];
      //print(business[0]);
      emit(NewGetsportSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewGetsportErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewGetscienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', qurey: {
      'country': 'eg ',
      'category': 'business',
      'apikey': '65f7f556ec76449fa7dc7c0069f040ca'
    }).then((value) {
      //print(value.data.toString());
      science = value.data['articles'];
      //print(business[0]);
      emit(NewGetscienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewGetscienceErrorState(error.toString()));
    });
  }
}
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=65f7f556ec76449fa7dc7c0069f040ca
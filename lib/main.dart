import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/layout/news_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/news_app/cubit/states.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/shop_app/shop_layout.dart';
import 'package:flutter_application_1/modules/basics/login/loginscreen.dart';
import 'package:flutter_application_1/modules/counter_app/counter/counter_screen.dart';
import 'package:flutter_application_1/modules/shop_app/on_boarding/login/shop_login.dart';
import 'package:flutter_application_1/shared/bloc_observer.dart';
import 'package:flutter_application_1/shared/components/constants.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';
import 'package:flutter_application_1/shared/network/local/cach_helper.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_application_1/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'layout/news_app/news_layout.dart';

import 'layout/todo_app/todo_layout.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'modules/shop_app/register/cubit/cubit.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  if (CachHelper.getData(key: 'isdark') != null) {
    isdark = CachHelper.getData(key: 'isdark');
  }

  Widget widget;
  var onBoarding = CachHelper.getData(key: 'onBoarding');

  if (CachHelper.getData(key: 'token') != null) {
    token = CachHelper.getData(key: 'token');
  }

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(isdark!, widget));
}

class MyApp extends StatelessWidget {
  final bool isdark;
  final Widget startwidget;
  MyApp(this.isdark, this.startwidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()),
        BlocProvider(
            create: (context) => AppCubit()..changeAppMode(fromShared: isdark)),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategorie()
              ..getfavorites()
              ..getproFileData()),
        BlocProvider(create: (context) => ShopRegisterCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).getIsDark()
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: this.startwidget);
        },
      ),
    );
  }
}

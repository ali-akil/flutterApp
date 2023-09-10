import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/news_app/cubit/states.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/news_app/serach/serach_screen.dart';
import 'cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, SerachScreen());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: () {
                    AppCubit.get(context).changeAppMode();
                    // NewsCubit.get(context)..getBusiness();
                  },
                ),
              ),
            ],
            title: Text("News App"),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.cureentIndex,
            onTap: (index) {
              cubit.ChangeBottonNavBar(index);
            },
          ),
          body: cubit.screens[cubit.cureentIndex],
        );
      },
    );
  }
}

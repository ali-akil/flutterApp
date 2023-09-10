import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/shop_app/search/cubit.dart';
import 'package:flutter_application_1/modules/shop_app/search/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Column(
                  children: [],
                ));
            ;
          },
        ));
  }
}

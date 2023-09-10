import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/news_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/news_app/cubit/states.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: ((context, state) {
        var list = NewsCubit.get(context).business;
        NewsCubit.get(context).getBusiness();
        return ConditionalBuilder(
            condition: true, //state is! NewGetBusinessLoadingState,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildArticaleItem(list, context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: 3),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      }),
    );
  }
}

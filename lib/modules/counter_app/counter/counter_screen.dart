import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/counter_app/counter/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/states.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (buildContext) => CounterCubit(),
        child: BlocConsumer<CounterCubit, CounterStates>(
            listener: (context, state) {
          if (state
              is CounterMunisState) {} //print('Minus state ${state.counter}');
          if (state
              is CounterPlusState) {} //print("Plus state ${state.counter}");
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Counter"),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).munis();
                      },
                      child: const Text("MINUS",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      '${CounterCubit.get(context).counter}',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                      },
                      child: const Text("PLUS",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400))),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

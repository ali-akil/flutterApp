import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'package:intl/intl.dart';
//import 'package:flutter_application_1/shared/components/constants';

import '../../shared/cubit/cubit.dart';

//1.create data base && create tables
//2.open database
//3.insert to database
//4.get database
//5.update database
//6.delete database
class HomeLayout extends StatelessWidget {
  late Database database;

  var scaffoldkey = GlobalKey<ScaffoldState>();
  var fromkey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context)..createDatabase();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppInsertDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomsheetShown) {
                    if (fromkey.currentState!.validate()) {
                      cubit.insertToDatabase(
                          title: titleController.text,
                          date: dateController.text,
                          time: timeController.text);

                      cubit.changeBottomSheetState(
                          isShow: false, icon: Icons.edit);
                      // cubit
                      //     .insertToDatabase(
                      //         title: titleController.text,
                      //         time: timeController.text,
                      //         date: dateController.text)
                      //     .then((value) {
                      //   Navigator.pop(context);
                      //   cubit.getDataFromDatabase(database).then((value) {
                      //     //   tasks = value;
                      //     //   print(tasks);
                      //     //   isBottomsheetShown = false;
                      //     //   fabIcon = Icons.edit;

                      //   }
                      //   );
                      //});
                    }
                  } else {
                    scaffoldkey.currentState!
                        .showBottomSheet((context) => Container(
                              color: Colors.grey[100],
                              padding: EdgeInsets.all(20.0),
                              child: Form(
                                key: fromkey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultFormfiled(
                                        controller: titleController,
                                        type: TextInputType.text,
                                        label: "Task Title ",
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return "title  must not empty";
                                          }
                                          return null;
                                        },
                                        prefix: Icons.title),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    defaultFormfiled(
                                        controller: timeController,
                                        type: TextInputType.datetime,
                                        label: "Task Time ",
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            timeController.text = value!
                                                .format(context)
                                                .toString();
                                          });
                                        },
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return "time  must not empty";
                                          }
                                          return null;
                                        },
                                        prefix: Icons.watch_later_outlined),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    defaultFormfiled(
                                        controller: dateController,
                                        type: TextInputType.datetime,
                                        label: "Task Date ",
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '2024-08-07'))
                                              .then((value) {
                                            dateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                          });
                                        },
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return "date  must not empty";
                                          }
                                          return null;
                                        },
                                        prefix: Icons.calendar_month)
                                  ],
                                ),
                              ),
                            ))
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetState(
                          isShow: false, icon: Icons.edit);
                    });

                    cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                  }
                },
                child: Icon(cubit.fabIcon)),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 50,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeIndex(index);

                print(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'archive'),
              ],
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetdatabaseLodingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import '../../modules/todo_app/done_taskes/done_tasks_screen.dart';
import '../../modules/todo_app/new_taskes/new_tasks_screen.dart';
import '../components/constants.dart';
import '../network/local/cach_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];
  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];
  List<String> titles = ["New Taskes", "Done Taskes", "Archived Taskes"];

  static AppCubit get(context) {
    return BlocProvider.of(context);
  }

  // ignore: non_constant_identifier_names
  void ChangeIndex(index) {
    this.currentIndex = index;
    emit(AppChangeBottomNavBarState(index));
  }

  var database;

  void createDatabase() {
    openDatabase("todo.db", version: 1, onCreate: (database, version) {
      // id integer
      //title String
      //Date  String
      //time String
      // status String
      print("database created");
      database
          .execute(
              "CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)")
          .then((value) {
        print("table create");
      }).catchError((error) {
        print("error when creating table ${error.toString()}");
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print("database opened");
    }).then((value) {
      emit(AppCreateDatabaseState());
      database = value;
    });
  }

// inserrt row into table
  insertToDatabase(
      {required String title,
      required String date,
      required String time}) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title ,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value insert successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print("Error when Inserting  New Record ${error.toString()}");
      });
      return null;
    });
  }

  void getDataFromDatabase(database) {
    newtasks = [];
    donetasks = [];
    archivedtasks = [];
    emit(AppGetdatabaseLodingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newtasks.add(element);
        } else if (element['status'] == 'done') {
          donetasks.add(element);
        } else {
          archivedtasks.add(element);
        }
      });
      print('new : $newtasks');
      print('done : $donetasks');
      print('archived : $archivedtasks');
      emit(AppGetDatabaseState());
    });
  }

  void upDateData({required String status, required int id}) async {
    database.rawUpdate('UPDATE tasks SET status = ?  where id=?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({required int id}) async {
    database.rawUpdate('DELETE FROM tasks  where id=?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppdeleteDatabaseState());
    });
  }

  bool isBottomsheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomsheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  ThemeMode appmode = ThemeMode.dark;
  void changeAppMode({var fromShared}) {
    if (fromShared != null) {
      isdark = fromShared;
      emit(AppChangeModeState());
    } else {
      isdark = !isdark!;
      CachHelper.putBoolean(key: 'isdark', value: isdark!).then((value) {});
      emit(AppChangeModeState());
    }
  }

  bool getIsDark() {
    return isdark!;
  }
}

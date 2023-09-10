abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {
  final int index;
  AppChangeBottomNavBarState(this.index);
}

class AppCreateDatabaseState extends AppStates {}

class AppGetDatabaseState extends AppStates {}

class AppInsertDatabaseState extends AppStates {}

class AppUpdateDatabaseState extends AppStates {}

class AppdeleteDatabaseState extends AppStates {}

class AppChangeBottomSheetState extends AppStates {}

class AppGetdatabaseLodingState extends AppStates {}

class AppChangeModeState extends AppStates {}

import 'package:flutter_application_1/models/shop_app/login_model.dart';

import '../../../models/shop_app/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopeLoadingHomeDataState extends ShopStates {}

class ShopeSuccessHomeDataState extends ShopStates {}

class ShopeErrorHomeDataState extends ShopStates {}

class ShopeLoadingCategoriesState extends ShopStates {}

class ShopeSuccessCategoriesState extends ShopStates {}

class ShopeErrorCategoriesState extends ShopStates {}

class ShopeSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;
  ShopeSuccessChangeFavoritesState(this.model);
}

class ShopeErrorChangeFavoritesState extends ShopStates {}

class ShopeChangeFavoritesState extends ShopStates {}

class ShopeSuccess_GET_FavoritesState extends ShopStates {}

class ShopeLoading_GET_FavoritesState extends ShopStates {}

class ShopeError_GET_FavoritesState extends ShopStates {}

class ShopeSuccess_UserProfileData_State extends ShopStates {
  final ShopLoginModle model;
  ShopeSuccess_UserProfileData_State(this.model);
}

class ShopeLoading_UserProfileData_State extends ShopStates {}

class ShopeError_UserProfileData_State extends ShopStates {}

class ShopeSuccessUpdateDataState extends ShopStates {
  final ShopLoginModle model;
  ShopeSuccessUpdateDataState(this.model);
}

class ShopeLoadingUpdateDataState extends ShopStates {}

class ShopeErrorUpdateDataState extends ShopStates {}

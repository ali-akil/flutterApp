import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/states.dart';
import 'package:flutter_application_1/models/shop_app/categories_model.dart';
import 'package:flutter_application_1/models/shop_app/change_favorites_model.dart';
import 'package:flutter_application_1/models/shop_app/home_model.dart';
import 'package:flutter_application_1/models/shop_app/login_model.dart';
import 'package:flutter_application_1/modules/shop_app/cateogries/cateogries_screen.dart';
import 'package:flutter_application_1/modules/shop_app/favoirtes/favoirtes_screen.dart';
import 'package:flutter_application_1/modules/shop_app/products/products_screen.dart';
import 'package:flutter_application_1/modules/shop_app/settings/settings.dart';
import 'package:flutter_application_1/shared/components/constants.dart';
import 'package:flutter_application_1/shared/network/end_points.dart';
import 'package:flutter_application_1/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/shop_app/favorites_modle.dart';
import '../../../shared/network/local/cach_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    productsScreen(),
    CateogriesScreen(),
    FavoirtesScreen(),
    SettingsScreen()
  ];
  void ChangeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int, bool> favorites = {};
  HomeModel? homeModle;
  void getHomeData() {
    emit(ShopeLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      emit(ShopeSuccessHomeDataState());
      homeModle = HomeModel.fromJson(value.data);
      homeModle!.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.in_favorites!});
      });
      //  print(favorites);
    }).catchError((error) {
      print(error.toString());
      emit(ShopeErrorHomeDataState());
    });
  }

  CategoriesModel? categoreModle;
  void getCategorie() {
    emit(ShopeLoadingCategoriesState());
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      //print(token);
      emit(ShopeSuccessCategoriesState());
      categoreModle = CategoriesModel.fromJson(value.data);
    }).catchError((error) {
      print(error.toString());
      emit(ShopeErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int product_id) {
    favorites[product_id] = !favorites[product_id]!;
    emit(ShopeChangeFavoritesState());
    DioHelper.postData(
            url: FAVORITES, data: {"product_id": product_id}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJason(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[product_id] = !favorites[product_id]!;
      } else {
        getfavorites();
      }
      emit(ShopeSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[product_id] = !favorites[product_id]!;
      emit(ShopeErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getfavorites() {
    emit(ShopeLoading_GET_FavoritesState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      // print(token);
      emit(ShopeSuccess_GET_FavoritesState());
      favoritesModel = FavoritesModel.fromJson(value.data);
    }).catchError((error) {
      print(error.toString());
      emit(ShopeError_GET_FavoritesState());
    });
  }

  ShopLoginModle? profileUserModel;
  void getproFileData() {
    emit(ShopeLoading_UserProfileData_State());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profileUserModel = ShopLoginModle.Fromjson(value.data);

      emit(ShopeSuccess_UserProfileData_State(profileUserModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopeError_UserProfileData_State());
    });
  }

  void updateData(
      {required String name, required String email, required String phone}) {
    emit(ShopeLoadingUpdateDataState());
    DioHelper.putData(
        url: UPDATE_PEOFILE,
        token: token,
        data: {'name': name, 'email': email, 'phone': phone}).then((value) {
      profileUserModel = ShopLoginModle.Fromjson(value.data);

      emit(ShopeSuccess_UserProfileData_State(profileUserModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopeError_UserProfileData_State());
    });
  }
}

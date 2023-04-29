import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_app/cubit/states.dart';
import 'package:news_app/models/shop_app/categories_model.dart';
import 'package:news_app/models/shop_app/change_favorites_model.dart';
import 'package:news_app/models/shop_app/favorites_model.dart';
import 'package:news_app/models/shop_app/home_model.dart';
import 'package:news_app/models/shop_app/login_model.dart';
import 'package:news_app/modules/shop_app/categories/categories_screen.dart';
import 'package:news_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:news_app/modules/shop_app/products/products_screen.dart';
import 'package:news_app/modules/shop_app/settings/settings_screen.dart';
import 'package:news_app/network/end_points.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  //ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    if (index == 3) {
      getUserData();
    }
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
            url: home,
            token:
                'b676yF4HQTAGtP9bYNM2kjAw3VZ6vd63Ar7dr7jQvhISokVKIK5K3Emr4tiPctOBgBlZhV')
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        favorites.addAll({element.id: element.inFavorites});
      }
      //  print(homeModel.toString());

      emit(ShopSuccesHomeDataState());
    }).catchError((error) {
      //  print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(
      url: getCATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccesCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: favorities,
      data: {
        'product_id': productId,
      },
      token:
          'VLxFzWKHoAqvnQ0wsbls9aQcmadGPxaHExnty4DMq4LG4PVT2R3nXzEGcKsZjZz79vYolL',
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccesChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: favorities,
      token:
          'VLxFzWKHoAqvnQ0wsbls9aQcmadGPxaHExnty4DMq4LG4PVT2R3nXzEGcKsZjZz79vYolL',
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccesGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: profile,
      token:
          'b676yF4HQTAGtP9bYNM2kjAw3VZ6vd63Ar7dr7jQvhISokVKIK5K3Emr4tiPctOBgBlZhV',
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccesUserDataState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
            url: uPDATEPROFILE,
            data: {
              'name': name,
              'email': email,
              'phone': phone,
            },
            token:
                'WLVHeOcbPBHuvTcTOk7C2YvXwYCz3nTYNsaiVn3DkhJT3KZw4moSyo8tfw9DCPtDtRLHwj')
        .then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccesUpdateUserState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUpdateUserState());
    });
  }
}

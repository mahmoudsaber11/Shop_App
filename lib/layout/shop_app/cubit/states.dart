import 'package:news_app/models/shop_app/change_favorites_model.dart';
import 'package:news_app/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccesHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccesCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccesChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccesChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccesGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccesUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccesUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccesUpdateUserState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccesUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}

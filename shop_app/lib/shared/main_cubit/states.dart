import 'package:shop_app/models/addressModels/add_address_model.dart';
import 'package:shop_app/models/addressModels/update&delete.dart';
import 'package:shop_app/models/cartModels/add_to_cart_model.dart';
import 'package:shop_app/models/categoriesModels/categories_details_model.dart';
import 'package:shop_app/models/favoritesModels/change_favorites_model.dart';
import 'package:shop_app/models/profileModels/complaint_model.dart';
import 'package:shop_app/models/profileModels/user_model.dart';

abstract class MainStates {}

class MainInitial extends MainStates {}

class ChangeBottomNavState extends MainStates {}

class ChangeDarkModeState extends MainStates {}

class ChangeCountryState extends MainStates {}

class FavoritesInLoadingState extends MainStates {}

//get home data
class LoadingHomeModelDataState extends MainStates {}

class SuccessHomeModelDataState extends MainStates {}

class ErrorHomeModelDataState extends MainStates {}
//get home data

//get categories data
class SuccessCategoriesModelDataState extends MainStates {}

class ErrorCategoriesModelDataState extends MainStates {}
//get home data

//change get favorites data
class LoadingChangeFavoritesModelDataState extends MainStates {}

class SuccessChangeFavoritesModelDataState extends MainStates {
  final ChangeToFavoritesModel model;

  SuccessChangeFavoritesModelDataState(this.model);
}

class ErrorChangeFavoritesModelDataState extends MainStates {}
//change favorites data

//get favorites data
class LoadingGetFavoritesModelDataState extends MainStates {}

class SuccessGetFavoritesModelDataState extends MainStates {}

class ErrorGetFavoritesModelDataState extends MainStates {}
//get favorites data

//get profile data
class LoadingGetProfileModelDataState extends MainStates {}

class SuccessGetProfileModelDataState extends MainStates {
  final UserModel userModel;

  SuccessGetProfileModelDataState(this.userModel);
}

class ErrorGetProfileModelDataState extends MainStates {}
//get profile data

//update profile data
class LoadingUpdateProfileModelDataState extends MainStates {}

class SuccessUpdateProfileModelDataState extends MainStates {
  final UserModel userModel;

  SuccessUpdateProfileModelDataState(this.userModel);
}

class ErrorUpdateProfileModelDataState extends MainStates {}
//update favorites data

//get faq
class LoadingGetFAQModelDataState extends MainStates {}

class SuccessGetFAQModelDataState extends MainStates {
  // final UserModel userModel;

  // SuccessUpdateProfileModelDataState(this.userModel);
}

class ErrorGetFAQModelDataState extends MainStates {}
//get faq

//change password
class ChangePassLoadingState extends MainStates {}

class ChangePassSuccessState extends MainStates {
  // final UserModel userModel;

  // ChangePassSuccessState(this.userModel);
}

class ChangePassErrorState extends MainStates {}

class ChangeSuffixIconState extends MainStates {}
//change password

//new address
class NewAddressLoadingState extends MainStates {}

class NewAddressSuccessState extends MainStates {
  final AddAddressModel addAddressModel;

  NewAddressSuccessState(this.addAddressModel);
}

class NewAddressErrorState extends MainStates {}
//new address

//get address
class GetAddressLoadingState extends MainStates {}

class GetAddressSuccessState extends MainStates {
  // final UserModel userModel;

  // ChangePassSuccessState(this.userModel);
}

class GetAddressErrorState extends MainStates {}
//get address

//update address
class UpdateAddressLoadingState extends MainStates {}

class UpdateAddressSuccessState extends MainStates {
  final UpdateAddressModel updateAddressModel;

  UpdateAddressSuccessState(this.updateAddressModel);
}

class UpdateAddressErrorState extends MainStates {}
//update address

//delete address
class DeleteAddressLoadingState extends MainStates {}

class DeleteAddressSuccessState extends MainStates {
  // final UserModel userModel;

  // ChangePassSuccessState(this.userModel);
}

class DeleteAddressErrorState extends MainStates {}
//delete address

//send complaint
class SendComplaintLoadingState extends MainStates {}

class SendComplaintSuccessState extends MainStates {
  final ComplaintModel complaintModel;

  SendComplaintSuccessState(this.complaintModel);
}

class SendComplaintErrorState extends MainStates {}
//delete address

//get categories details
class GetCategoriesLoadingState extends MainStates {}

class GetCategoriesSuccessState extends MainStates {
  final CategoryDetailModel categoryDetailModel;

  GetCategoriesSuccessState(this.categoryDetailModel);
}

class GetCategoriesErrorState extends MainStates {}
//get categories details

//get products details
class GetProductsLoadingState extends MainStates {}

class GetProductsSuccessState extends MainStates {
  // final ProductDetailsModel productDetailsModel;

  // GetProductsSuccessState(this.productDetailsModel);
}

class GetProductsErrorState extends MainStates {}
//get products details

//add cart
class AddCartLoadingState extends MainStates {}

class AddCartSuccessState extends MainStates {
  final AddCartModel addCartModel;

  AddCartSuccessState(this.addCartModel);
}

class AddCartErrorState extends MainStates {}
//add cart

//add cart
class UpdateCartLoadingState extends MainStates {}

class UpdateCartSuccessState extends MainStates {}

class UpdateCartErrorState extends MainStates {}
//add cart

//get cart
class GetCartLoadingState extends MainStates {}

class GetCartSuccessState extends MainStates {}

class GetCartErrorState extends MainStates {}
//get cart

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/addressModels/add_address_model.dart';
import 'package:shop_app/models/addressModels/address_model.dart';
import 'package:shop_app/models/addressModels/update&delete.dart';
import 'package:shop_app/models/cartModels/add_to_cart_model.dart';
import 'package:shop_app/models/cartModels/get_cart_model.dart';
import 'package:shop_app/models/cartModels/update_cart_model.dart';
import 'package:shop_app/models/categoriesModels/categories_details_model.dart';
import 'package:shop_app/models/categoriesModels/categories_model.dart';
import 'package:shop_app/models/favoritesModels/change_favorites_model.dart';
import 'package:shop_app/models/favoritesModels/get_favorites_model.dart';
import 'package:shop_app/models/homeModels/home_model.dart';
import 'package:shop_app/models/homeModels/products%20_details_model.dart';
import 'package:shop_app/models/profileModels/complaint_model.dart';
import 'package:shop_app/models/profileModels/faqs_models.dart';
import 'package:shop_app/models/profileModels/user_model.dart';
import 'package:shop_app/modules/cart_screen/cart_screen.dart';
import 'package:shop_app/modules/categories_screen/categories_screen.dart';
import 'package:shop_app/modules/favorites_screen/favorites_screen.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

//botton nav bar
  int currentIndex = 0;
  List<Widget> bottomNavScreens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    CartScreen(),
  ];
  void changeBottomNavScreen(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
  //botton nav bar

  //dark mode
  bool isDark = CacheHelper.getData('isDark') ?? false;
  void switchValue() {
    isDark = !isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark);
    emit(ChangeDarkModeState());
  }
  //dark mode

  //change country
  dynamic valueChoose = CacheHelper.getData('country') ?? 'Egypt';
  List countryItems = const [
    'Egypt',
    'Saudi',
    'Jordan',
    'Kuwait',
    'Libya',
  ];
  void changeCountry() {
    CacheHelper.saveData(key: 'country', value: valueChoose);
    emit(ChangeCountryState());
  }
  //change country

  //get home data
  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(LoadingHomeModelDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then(
      (value) {
        homeModel = HomeModel.fromJson(value.data);
        homeModel!.data!.products.forEach((element) {
          favorites.addAll(
            {element.id!: element.inFavorites!},
          );
        });
        homeModel!.data!.products.forEach((element) {
          cart.addAll({element.id: element.inCart});
        });
        // {
        //   showToast(
        //     message: 'Image error',
        //     state: ToastStates.WARNING,
        //   );
        // }

        emit(SuccessHomeModelDataState());
      },
    ).catchError(
      (error) {
        emit(ErrorHomeModelDataState());
      },
    );
  }
  //get home data

  //get categories data
  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then(
      (value) {
        categoriesModel = CategoriesModel.fromJson(value.data);

        emit(SuccessCategoriesModelDataState());
      },
    ).catchError(
      (error) {
        print(error);
        emit(ErrorCategoriesModelDataState());
      },
    );
  }
  //get categories data

  //change favorites data
  ChangeToFavoritesModel? changeToFavoritesModel;
  void changeFavorites(int? productId) {
    favorites[productId!] = !favorites[productId]!;
    emit(LoadingChangeFavoritesModelDataState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then(
      (value) {
        changeToFavoritesModel = ChangeToFavoritesModel.fromJson(value.data);
        if (!changeToFavoritesModel!.status!) {
          favorites[productId] = !favorites[productId]!;
        } else {
          getFavorites();
        }

        emit(SuccessChangeFavoritesModelDataState(changeToFavoritesModel!));
      },
    ).catchError(
      (error) {
        print(error);
        favorites[productId] = !favorites[productId]!;

        emit(ErrorChangeFavoritesModelDataState());
      },
    );
  }
  //change favorites data

  //get favorites data
  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(LoadingGetFavoritesModelDataState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then(
      (value) {
        favoritesModel = FavoritesModel.fromJson(value.data);
        emit(SuccessGetFavoritesModelDataState());
      },
    ).catchError(
      (error) {
        print(error);
        emit(ErrorGetFavoritesModelDataState());
      },
    );
  }
  //get favorites data

  //get profile data
  UserModel? userModel;
  void getProfileData() {
    emit(LoadingGetProfileModelDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then(
      (value) {
        userModel = UserModel.fromJson(value.data);
        emit(SuccessGetProfileModelDataState(userModel!));
      },
    ).catchError(
      (error) {
        print(error);
        emit(ErrorGetProfileModelDataState());
      },
    );
  }
  //get profile data

  //update profile data
  //UserModel? updateUserModel;
  void updateProfileData(
    String name,
    String email,
    String phone,
  ) {
    emit(LoadingUpdateProfileModelDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then(
      (value) {
        userModel = UserModel.fromJson(value.data);
        emit(SuccessUpdateProfileModelDataState(userModel!));
      },
    ).catchError(
      (error) {
        print(error);
        emit(ErrorUpdateProfileModelDataState());
      },
    );
  }
  //update favorites data

  //get favorites data
  FAQsModel? faqsModel;
  void getFAQ() {
    emit(LoadingGetFAQModelDataState());
    DioHelper.getData(
      url: FAQ,
    ).then(
      (value) {
        faqsModel = FAQsModel.fromJson(value.data);
        emit(SuccessGetFAQModelDataState());
      },
    ).catchError(
      (error) {
        print(error);
        emit(ErrorGetFAQModelDataState());
      },
    );
  }
  //get favorites data

  //change password
  UserModel? passwordModel;
  void changePassword({
    required context,
    required String currentPass,
    required String newPass,
  }) {
    emit(ChangePassLoadingState());
    DioHelper.postData(
      url: CHANGE_PASSWORD,
      token: token,
      data: {
        'current_password': currentPass,
        'new_password': newPass,
      },
    ).then(
      (value) {
        passwordModel = UserModel.fromJson(value.data);
        if (passwordModel!.status) {
          pop(context);
        } else
          emit(ChangePassSuccessState());
      },
    ).catchError(
      (error) {
        emit(ChangePassErrorState());
        print(error.toString());
      },
    );
  }

  bool showCurrentPassword = false;
  IconData currentPasswordIcon = Icons.visibility;
  void changeCurrentPassIcon(context) {
    showCurrentPassword = !showCurrentPassword;
    if (showCurrentPassword)
      currentPasswordIcon = Icons.visibility_off;
    else
      currentPasswordIcon = Icons.visibility;
    emit(ChangeSuffixIconState());
  }

  bool showNewPassword = false;
  IconData newPasswordIcon = Icons.visibility;
  void changeNewPassIcon(context) {
    showNewPassword = !showNewPassword;
    if (showNewPassword)
      newPasswordIcon = Icons.visibility_off;
    else
      newPasswordIcon = Icons.visibility;
    emit(ChangeSuffixIconState());
  }

  bool showNewnewConfirmPassword = false;
  IconData newConfirmPasswordIcon = Icons.visibility;
  void changeNewConfirmPassIcon(context) {
    showNewnewConfirmPassword = !showNewnewConfirmPassword;
    if (showNewnewConfirmPassword)
      newConfirmPasswordIcon = Icons.visibility_off;
    else
      newConfirmPasswordIcon = Icons.visibility;
    emit(ChangeSuffixIconState());
  }
  //change password

  //add address
  AddAddressModel? addAddressModel;
  void addAddress({
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }) {
    emit(NewAddressLoadingState());
    DioHelper.postData(
      url: ADDRESSES,
      token: token,
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': latitude,
        'longitude': longitude,
      },
    ).then((value) {
      addAddressModel = AddAddressModel.fromJson(value.data);
      if (addAddressModel!.status)
        getAddresses();
      else
        // showTopSnackBar(
        //         context,
        //         CustomSnackBar.success(
        //           backgroundColor: Colors.red,
        //           message: state.model.message!,
        //           icon: Icon(null),
        //         ),
        //       );
        // showToast(
        //   message: addAddressModel!.message!,
        //   state: ToastStates.ERROR,
        // );
        emit(NewAddressSuccessState(addAddressModel!));
    }).catchError((error) {
      emit(NewAddressErrorState());
      print(error.toString());
    });
  }
  //add address

  //get address
  AddressModel? addressModel;
  void getAddresses() {
    emit(GetAddressLoadingState());
    DioHelper.getData(
      url: ADDRESSES,
      token: token,
    ).then(
      (value) {
        addressModel = AddressModel.fromJson(value.data);
        emit(GetAddressSuccessState());
      },
    ).catchError(
      (error) {
        emit(GetAddressErrorState());
        print(error.toString());
      },
    );
  }
  //get address

  //update address
  UpdateAddressModel? updateAddressModel;
  void updateAddress({
    required int? addressId,
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }) {
    emit(UpdateAddressLoadingState());
    DioHelper.putData(
      url: 'addresses/$addressId',
      token: token,
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': latitude,
        'longitude': longitude,
      },
    ).then(
      (value) {
        updateAddressModel = UpdateAddressModel.fromJson(value.data);
        if (updateAddressModel!.status) getAddresses();
        emit(UpdateAddressSuccessState(updateAddressModel!));
      },
    ).catchError(
      (error) {
        emit(UpdateAddressErrorState());
        print(error.toString());
      },
    );
  }
  //update address

  //delete address
  UpdateAddressModel? deleteAddressModel;
  void deleteAddress({required addressId}) {
    emit(DeleteAddressLoadingState());
    DioHelper.deleteData(
      url: 'addresses/$addressId',
      token: token,
    ).then((value) {
      deleteAddressModel = UpdateAddressModel.fromJson(value.data);
      if (deleteAddressModel!.status) getAddresses();
      emit(DeleteAddressSuccessState());
    }).catchError((error) {
      emit(DeleteAddressErrorState());
      print(error.toString());
    });
  }
  //delete address

  //send complaint
  ComplaintModel? complaintModel;
  void sendComplaint(
    String name,
    String phone,
    String email,
    String message,
  ) {
    emit(SendComplaintLoadingState());
    DioHelper.postLoginData(
      url: COMPLAINTS,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'message': message,
      },
    ).then(
      (value) {
        complaintModel = ComplaintModel.fromJson(value.data);
        emit(SendComplaintSuccessState(complaintModel!));
      },
    ).catchError(
      (error) {
        print(error);
        emit(SendComplaintErrorState());
      },
    );
  }
  //send complaint

  //get categories details
  // CategoryDetailModel? categoryDetailModel;
  // void getCategoriesDetails(int? categoriesId) {
  //   emit(GetCategoriesLoadingState());
  //   DioHelper.getData(
  //     url: 'categories/$categoriesId',
  //     token: token,
  //   ).then(
  //     (value) {
  //       categoryDetailModel = CategoryDetailModel.fromJson(value.data);
  //       emit(GetCategoriesSuccessState(categoryDetailModel!));
  //     },
  //   ).catchError(
  //     (error) {
  //       emit(GetCategoriesErrorState());
  //       print(error.toString());
  //     },
  //   );
  // }
  CategoryDetailModel? categoryDetailModel;
  void getCategoriesDetails(int? categoryID) {
    emit(GetCategoriesLoadingState());
    DioHelper.getData(
      url: CATEGORIES_DETAILS,
      query: {
        'category_id': '$categoryID',
      },
      token: token,
    ).then((value) {
      categoryDetailModel = CategoryDetailModel.fromJson(value.data);
      emit(GetCategoriesSuccessState(categoryDetailModel!));
    }).catchError((error) {
      emit(GetCategoriesErrorState());
      print(error.toString());
    });
  }
  //get categories details

  //get products details
  ProductDetailsModel? productDetailsModel;
  void getProductsDetails(int? productID) {
    emit(GetProductsLoadingState());
    DioHelper.getData(
      url: 'products/$productID',
      token: token,
    ).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(GetProductsSuccessState());
    }).catchError((error) {
      emit(GetProductsErrorState());
      print(error.toString());
    });
  }
  //get products details

  //add to cart
  Map<dynamic, dynamic> cart = {};
  late AddCartModel addCartModel;
  void addToCart(int? productID) {
    emit(AddCartLoadingState());
    DioHelper.postData(
      url: CARTS,
      token: token,
      data: {'product_id': productID},
    ).then((value) {
      addCartModel = AddCartModel.fromJson(value.data);
      if (addCartModel.status) {
        getCartData();
        getHomeData();
      } else
        // showToast(
        //   message: addCartModel.message!,
        //   state: ToastStates.ERROR,
        // );
        emit(AddCartSuccessState(addCartModel));
    }).catchError((error) {
      emit(AddCartErrorState());
      print(error.toString());
    });
  }
  //add to cart

  //update cart
  late UpdateCartModel updateCartModel;
  void updateCartData(
    int? cartId,
    int? quantity,
  ) {
    emit(UpdateCartLoadingState());
    DioHelper.putData(
      url: 'carts/$cartId',
      data: {
        'quantity': '$quantity',
      },
      token: token,
    ).then((value) {
      updateCartModel = UpdateCartModel.fromJson(value.data);
      if (updateCartModel.status)
        getCartData();
      else
        // showToast(
        //   message: updateCartModel.message!,
        //   state: ToastStates.ERROR,
        // );
        emit(UpdateCartSuccessState());
    }).catchError((error) {
      emit(UpdateCartErrorState());
      print(error.toString());
    });
  }
  //update cart

  //get cart
  CartModel? cartModel;
  void getCartData() {
    emit(GetCartLoadingState());
    DioHelper.getData(
      url: CARTS,
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(GetCartSuccessState());
    }).catchError((error) {
      emit(GetCartErrorState());
      print(error.toString());
    });
  }
  //get cart
}

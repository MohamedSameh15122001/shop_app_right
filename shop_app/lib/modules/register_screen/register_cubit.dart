import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/profileModels/user_model.dart';
import 'package:shop_app/modules/register_screen/register_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  UserModel? loginModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then(
      (value) {
        loginModel = UserModel.fromJson(value.data);
        emit(RegisterSuccessState(loginModel!));
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(RegisterErrorState(error.toString()));
      },
    );
  }

  bool obscureText = false;
  void enablePassword() {
    obscureText = !obscureText;
    emit(RegisterEnablePasswordState());
  }

  bool obscureConfirmText = false;
  void enableConfirmPassword() {
    obscureConfirmText = !obscureConfirmText;
    emit(RegisterEnablePasswordState());
  }
}

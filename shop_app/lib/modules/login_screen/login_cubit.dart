import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/profileModels/user_model.dart';
import 'package:shop_app/modules/login_screen/login_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postLoginData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then(
      (value) {
        loginModel = UserModel.fromJson(value.data);
        emit(LoginSuccessState(loginModel!));
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(LoginErrorState(error.toString()));
      },
    );
  }

  bool obscureText = false;
  void enablePassword() {
    obscureText = !obscureText;
    emit(LoginEnablePasswordState());
  }
}

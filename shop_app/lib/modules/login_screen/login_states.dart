import 'package:shop_app/models/profileModels/user_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginEnablePasswordState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final UserModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates {
  final error;

  LoginErrorState(this.error);
}

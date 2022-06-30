import 'package:shop_app/models/profileModels/user_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterEnablePasswordState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final UserModel loginModel;

  RegisterSuccessState(this.loginModel);
}

class RegisterErrorState extends RegisterStates {
  final error;

  RegisterErrorState(this.error);
}

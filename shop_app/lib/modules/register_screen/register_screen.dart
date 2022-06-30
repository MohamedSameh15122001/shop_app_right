import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/main_layout.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/register_screen/register_cubit.dart';
import 'package:shop_app/modules/register_screen/register_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //variables
    var emailControler = TextEditingController();
    var passwordControler = TextEditingController();
    var fullnameControler = TextEditingController();
    var phoneNumberControler = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    var registerFormKey = GlobalKey<FormState>();
    //variables
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status == true) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data?.token,
              ).then(
                (value) {
                  token = state.loginModel.data!.token;
                  navigateAndFinish(context, MainLayout());
                  emailControler.clear();
                  passwordControler.clear();
                  confirmPassword.clear();
                  showTopSnackBar(
                    context,
                    CustomSnackBar.success(
                      backgroundColor: Colors.green,
                      message: state.loginModel.message ?? 'error',
                      icon: Icon(null),
                    ),
                  );
                  // showToast(
                  //   message: state.loginModel.message ?? 'error',
                  //   state: ToastStates.SUCCESS,
                  // );
                },
              );
            } else {
              showTopSnackBar(
                context,
                CustomSnackBar.success(
                  backgroundColor: Colors.red,
                  message: state.loginModel.message ?? 'error',
                  icon: Icon(null),
                ),
              );
              //print(state.loginModel.message);
              // showToast(
              //   message: state.loginModel.message ?? 'error',
              //   state: ToastStates.ERROR,
              // );
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: defaultColor,
              //backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: defaultColor,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(110),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 100,
                          ),
                          child: const Image(
                            height: 240,
                            width: 100,
                            color: Colors.white,
                            fit: BoxFit.contain,
                            image: const AssetImage(
                              'assets/images/logo_2.png',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 120,
                            left: 250,
                          ),
                          child: Text(
                            'Register',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: white,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 24,
                    ),
                    child: Form(
                      key: registerFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Fullname Must Not Be Empty';
                                }
                              },
                              controller: fullnameControler,
                              keyboardType: TextInputType.name,
                              cursorColor: defaultColor,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  height: 0,
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                hintText: 'Fullname',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.grey[500],
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email Address Must Not Be Empty';
                                }
                              },
                              cursorColor: defaultColor,
                              controller: emailControler,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  height: 0,
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                hintText: 'Email',
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.grey[500],
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone numer Must Not Be Empty';
                                }
                              },
                              cursorColor: defaultColor,
                              controller: phoneNumberControler,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  height: 0,
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                hintText: 'Phone Number',
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.grey[500],
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password Must Not Be Empty';
                                }
                              },
                              controller: passwordControler,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: cubit.obscureText ? true : false,
                              cursorColor: defaultColor,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  height: 0,
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                hintText: 'Password',
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.grey[500],
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.enablePassword();
                                  },
                                  icon: cubit.obscureText
                                      ? Icon(
                                          Icons.visibility,
                                          color: Colors.grey[500],
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey[500],
                                        ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                // if (registerFormKey.currentState!.validate()) {
                                //   cubit.userRegister(
                                //     name: fullnameControler.text,
                                //     email: emailControler.text,
                                //     password: passwordControler.text,
                                //     phone: phoneNumberControler.text,
                                //   );
                                // }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Confirm Password Must Not Be Empty';
                                else if (value != passwordControler.text)
                                  return 'Password Don\'t Match';
                              },
                              controller: confirmPassword,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText:
                                  cubit.obscureConfirmText ? true : false,
                              cursorColor: defaultColor,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  height: 0,
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                hintText: 'Confirm Password',
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.grey[500],
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.enableConfirmPassword();
                                  },
                                  icon: cubit.obscureConfirmText
                                      ? Icon(
                                          Icons.visibility,
                                          color: Colors.grey[500],
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey[500],
                                        ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                internetConection(context);
                                if (registerFormKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    name: fullnameControler.text,
                                    email: emailControler.text,
                                    password: passwordControler.text,
                                    phone: phoneNumberControler.text,
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 34,
                          ),
                          BuildCondition(
                            condition: state is! RegisterLoadingState,
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(
                                color: defaultColor,
                              ),
                            ),
                            builder: (context) => Container(
                              decoration: BoxDecoration(
                                color: defaultColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 10,
                                    offset: const Offset(0, 6),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: () {
                                  internetConection(context);
                                  if (registerFormKey.currentState!
                                      .validate()) {
                                    cubit.userRegister(
                                      name: fullnameControler.text,
                                      email: emailControler.text,
                                      password: passwordControler.text,
                                      phone: phoneNumberControler.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already a member ?',
                              ),
                              TextButton(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: defaultColor,
                                  ),
                                ),
                                onPressed: () {
                                  navigateAndFinish(context, LoginScreen());
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

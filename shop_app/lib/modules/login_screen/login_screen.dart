import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/main_layout.dart';
import 'package:shop_app/modules/login_screen/login_cubit.dart';
import 'package:shop_app/modules/login_screen/login_states.dart';
import 'package:shop_app/modules/register_screen/register_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //variables
    var emailControler = TextEditingController();
    var passwordControler = TextEditingController();
    var loginFormKey = GlobalKey<FormState>();
    //variables
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status == true) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then(
                (value) {
                  token = state.loginModel.data!.token;
                  navigateAndFinish(context, MainLayout());
                  emailControler.clear();
                  passwordControler.clear();
                  showTopSnackBar(
                    context,
                    CustomSnackBar.success(
                      backgroundColor: Colors.green,
                      message: state.loginModel.message ?? 'error',
                      icon: Icon(null),
                    ),
                  );
                  MainCubit.get(context).currentIndex = 0;
                  MainCubit.get(context).getHomeData();
                  // MainCubit.get(context).getCategoriesData();
                  MainCubit.get(context).getFavorites();
                  MainCubit.get(context).getProfileData();
                  MainCubit.get(context).getAddresses();
                  MainCubit.get(context).getCartData();
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
              // showToast(
              //   message: state.loginModel.message ?? 'error',
              //   state: ToastStates.ERROR,
              // );
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
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
                    height: 240,
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
                            bottom: 90,
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
                            top: 140,
                            left: 250,
                          ),
                          child: Text(
                            'Login',
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
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      key: loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
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
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                hintText: 'Email',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey[500],
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                errorStyle: const TextStyle(
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              controller: passwordControler,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !cubit.obscureText ? true : false,
                              cursorColor: defaultColor,
                              onFieldSubmitted: (value) {
                                internetConection(context);
                                if (loginFormKey.currentState!.validate()) {
                                  cubit.userLogin(
                                    email: emailControler.text,
                                    password: passwordControler.text,
                                  );
                                }
                              },
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  height: 0,
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                hintText: 'Password',
                                suffixStyle: TextStyle(
                                  color: defaultColor,
                                ),
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password Must Not Be Empty';
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forget Password ?',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          // state is LoginLoadingState
                          //     ? Center(child: CircularProgressIndicator())
                          //     :
                          BuildCondition(
                            condition: state is! LoginLoadingState,
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
                                  if (loginFormKey.currentState!.validate()) {
                                    cubit.userLogin(
                                      email: emailControler.text,
                                      password: passwordControler.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  'LOGIN',
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
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account ?',
                              ),
                              TextButton(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: defaultColor,
                                  ),
                                ),
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
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

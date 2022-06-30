import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //vars
    var currentPass = TextEditingController();
    var newPass = TextEditingController();
    var newConfirmPass = TextEditingController();
    var changePasskey = GlobalKey<FormState>();
    //vars
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          // backgroundColor: Colors.grey[50],
          appBar: AppBar(
            //automaticallyImplyLeading: false,
            title: const Text(
              'Change Your Password',
              // style: TextStyle(
              //   fontSize: 20,
              //   fontWeight: FontWeight.w500,
              // ),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Container(
            width: double.infinity,
            //height: 280,
            padding: EdgeInsets.all(20),
            child: Form(
              key: changePasskey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (state is ChangePassLoadingState)
                  // BuildCondition(
                  //   condition: state is! ChangePassLoadingState,
                  //   fallback: (context) => Container(),
                  //   builder: (context) => Column(
                  //     children: [
                  //       LinearProgressIndicator(color: defaultColor),
                  //       SizedBox(
                  //         height: 20,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Text(
                    '   Current Password',
                    style: Theme.of(context).textTheme.bodyText1!,
                    // style: TextStyle(fontSize: 15),
                  ),
                  TextFormField(
                    cursorColor: defaultColor,
                    controller: currentPass,
                    textCapitalization: TextCapitalization.words,
                    obscureText: !MainCubit.get(context).showCurrentPassword
                        ? true
                        : false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      hintText: 'Please enter Current Password',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        color: Colors.grey,
                        onPressed: () {
                          MainCubit.get(context).changeCurrentPassIcon(context);
                        },
                        icon: Icon(MainCubit.get(context).currentPasswordIcon),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'This field cant be Empty';
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    '    New Password',
                    style: Theme.of(context).textTheme.bodyText1!,
                    // style: TextStyle(fontSize: 15),
                  ),
                  TextFormField(
                    controller: newPass,
                    textCapitalization: TextCapitalization.words,
                    obscureText:
                        !MainCubit.get(context).showNewPassword ? true : false,
                    cursorColor: defaultColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      hintText: 'Please enter New Password',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 15),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        color: Colors.grey,
                        onPressed: () {
                          MainCubit.get(context).changeNewPassIcon(context);
                        },
                        icon: Icon(MainCubit.get(context).newPasswordIcon),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'This field cant be Empty';
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    '    Confirm Password',
                    style: Theme.of(context).textTheme.bodyText1!,
                    // style: TextStyle(fontSize: 15),
                  ),
                  TextFormField(
                    controller: newConfirmPass,
                    textCapitalization: TextCapitalization.words,
                    obscureText:
                        !MainCubit.get(context).showNewnewConfirmPassword
                            ? true
                            : false,
                    cursorColor: defaultColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      hintText: 'Confirm New Password',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 15),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        color: Colors.grey,
                        onPressed: () {
                          MainCubit.get(context)
                              .changeNewConfirmPassIcon(context);
                        },
                        icon:
                            Icon(MainCubit.get(context).newConfirmPasswordIcon),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'Confirm Password Must Not Be Empty';
                      else if (value != newPass.text)
                        return 'Password Don\'t Match';
                    },
                  ),
                  const Spacer(),
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (changePasskey.currentState!.validate()) {
                          MainCubit.get(context).changePassword(
                            context: context,
                            currentPass: currentPass.text,
                            newPass: newPass.text,
                          );
                        }
                      },
                      child: const Text(
                        'Change Password',
                        style: TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

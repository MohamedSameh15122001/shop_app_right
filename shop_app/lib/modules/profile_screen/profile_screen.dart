import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/change_password_screen/change_password_scree.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //variables
    var screenHeight = MediaQuery.of(context).size.height;
    var emailControler = TextEditingController();
    var fullnameControler = TextEditingController();
    var phoneNumberControler = TextEditingController();
    var profileFormKey = GlobalKey<FormState>();
    //variables
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (MainCubit.get(context).userModel != null) {
          var model = MainCubit.get(context).userModel;
          emailControler.text = model!.data!.email!;
          fullnameControler.text = model.data!.name!;
          phoneNumberControler.text = model.data!.phone!;
        }

        return Scaffold(
          backgroundColor: defaultColor,
          appBar: AppBar(
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: BuildCondition(
            condition: MainCubit.get(context).userModel != null,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(
                color: white,
              ),
            ),
            builder: (context) => BuildCondition(
              condition: MainCubit.get(context).userModel != null,
              fallback: (context) => Center(
                  child: CircularProgressIndicator(
                color: defaultColor,
              )),
              builder: (context) => Form(
                key: profileFormKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: defaultColor,
                        height: screenHeight * 0.50,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (state is LoadingUpdateProfileModelDataState)
                                const LinearProgressIndicator(
                                  color: white,
                                ),
                              const SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                ),
                                child: const Text(
                                  'Name',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                ),
                                child: const Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
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
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                ),
                                child: const Text(
                                  'Phone',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
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
                              Row(
                                children: [
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      // CacheHelper.removeData('token').then(
                                      //   (value) {
                                      //     if (value)
                                      //       navigateAndFinish(context, LoginScreen());
                                      //     // ShopCubit.get(context).currentIndex = 0;
                                      //   },
                                      // );
                                      if (profileFormKey.currentState!
                                          .validate()) {
                                        MainCubit.get(context)
                                            .updateProfileData(
                                          fullnameControler.text,
                                          emailControler.text,
                                          phoneNumberControler.text,
                                        );
                                        // showTopSnackBar(
                                        //   context,
                                        //   CustomSnackBar.success(
                                        //     backgroundColor: Colors.green,
                                        //     message: MainCubit.get(context)
                                        //         .userModel!
                                        //         .message!,
                                        //     icon: Icon(null),
                                        //   ),
                                        // );
                                        // pop(context);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          color: white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: defaultColor,
                                              size: 22,
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              'Edit',
                                              style: TextStyle(
                                                color: defaultColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            const Text(
                              'SECURITY INFORMATION',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, ChangePasswordScreen());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  right: 20,
                                ),
                                child: Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      30,
                                    ),
                                    color: white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: defaultColor,
                                        size: 22,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        'Change Your Password',
                                        style: TextStyle(
                                          color: defaultColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      //Spacer(),
                      TextButton(
                        onPressed: () {
                          CacheHelper.removeData('token').then(
                            (value) {
                              if (value)
                                navigateAndFinish(context, LoginScreen());
                              // ShopCubit.get(context).currentIndex = 0;
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                30,
                              ),
                              color: white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.power_settings_new,
                                  color: defaultColor,
                                  size: 22,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'SignOut',
                                  style: TextStyle(
                                    color: defaultColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

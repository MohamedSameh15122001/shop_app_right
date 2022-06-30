import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //variables
    var emailControler = TextEditingController();
    var nameControler = TextEditingController();
    var phoneNumberControler = TextEditingController();
    var messageControler = TextEditingController();
    var complaintFormKey = GlobalKey<FormState>();
    //variables
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is SendComplaintSuccessState) {
          if (state.complaintModel.status!) {
            pop(context);
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                backgroundColor: Colors.green,
                message: state.complaintModel.message!,
                icon: Icon(null),
              ),
            );
            // showToast(
            //     message: state.complaintModel.message!,
            //     state: ToastStates.SUCCESS);

          } else {
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                backgroundColor: Colors.red,
                message: state.complaintModel.message!,
                icon: Icon(null),
              ),
            );
            // showToast(
            //   message: state.complaintModel.message!,
            //   state: ToastStates.ERROR,
            // );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: defaultColor,
          appBar: AppBar(
            title: const Text(
              'Complaint',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: complaintFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: defaultColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state is SendComplaintLoadingState)
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
                              controller: nameControler,
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
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                            ),
                            child: const Text(
                              'Message',
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
                            // child: TextField(
                            //   cursorColor: defaultColor,
                            //   controller: messageControler,
                            //   keyboardType: TextInputType.text,
                            //   decoration: InputDecoration(
                            //     errorStyle: const TextStyle(
                            //       height: 0,
                            //     ),
                            //     contentPadding: const
                            //         EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 10.0),
                            //     hintText: 'Please write your Message',
                            //     prefixIcon: Icon(
                            //       Icons.message,
                            //       color: Colors.grey[500],
                            //     ),
                            //     border: OutlineInputBorder(
                            //       borderSide: BorderSide.none,
                            //       borderRadius: BorderRadius.circular(30),
                            //     ),
                            //   ),
                            // ),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              minLines: 4,
                              maxLines: 6,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Message Must Not Be Empty';
                                }
                              },
                              cursorColor: defaultColor,
                              controller: messageControler,
                              // keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  height: 0,
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                hintText: 'Please write your Message',
                                // prefixIcon: Icon(
                                //   Icons.message,
                                //   color: Colors.grey[500],
                                // ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const SizedBox(
                            height: 130,
                          ),
                          TextButton(
                            onPressed: () {
                              if (complaintFormKey.currentState!.validate()) {
                                MainCubit.get(context).sendComplaint(
                                  nameControler.text,
                                  phoneNumberControler.text,
                                  emailControler.text,
                                  messageControler.text,
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 14,
                                left: 0,
                                right: 0,
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
                                      Icons.send,
                                      color: defaultColor,
                                      size: 22,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      'SEND',
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';

class AddAndUpdateAddressScreen extends StatelessWidget {
  final bool isEdit;
  final int? addressId;
  final String? name;
  final String? city;
  final String? region;
  final String? details;
  final String? notes;
  const AddAndUpdateAddressScreen({
    Key? key,
    required this.isEdit,
    this.addressId,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //variables
    var locationNameControler = TextEditingController();
    var cityNameControler = TextEditingController();
    var regionNameControler = TextEditingController();
    var detailsNameControler = TextEditingController();
    var notesNameControler = TextEditingController();
    var addressFormKey = GlobalKey<FormState>();
    //variables
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is UpdateAddressSuccessState) {
          if (state.updateAddressModel.status) pop(context);
        } else if (state is NewAddressSuccessState) {
          if (state.addAddressModel.status) pop(context);
        }
      },
      builder: (context, state) {
        if (isEdit) {
          locationNameControler.text = name ?? 'No Location Name Added';
          cityNameControler.text = city ?? 'No City Added';
          regionNameControler.text = region ?? 'No Region Added';
          detailsNameControler.text = details ?? 'No Details Added';
          notesNameControler.text = notes ?? 'No Notes Added';
        }
        return Scaffold(
          backgroundColor: defaultColor,
          appBar: AppBar(
            title: const Text(
              'New Address',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: addressFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is NewAddressLoadingState ||
                      state is UpdateAddressLoadingState)
                    Column(
                      children: [
                        LinearProgressIndicator(
                          color: defaultColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  Container(
                    color: defaultColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // if (state is LoadingUpdateProfileModelDataState)
                          //   LinearProgressIndicator(
                          //     color: white,
                          //   ),
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
                                  return 'Location Name Must Not Be Empty';
                                }
                              },
                              controller: locationNameControler,
                              keyboardType: TextInputType.text,
                              cursorColor: defaultColor,
                              // style: TextStyle(color: white),
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  height: 0,
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                hintText: 'Enter Your Location Name',
                                prefixIcon: Icon(
                                  Icons.location_on_outlined,
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
                              'City',
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
                                  return 'City Must Not Be Empty';
                                }
                              },
                              controller: cityNameControler,
                              keyboardType: TextInputType.text,
                              cursorColor: defaultColor,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  height: 0,
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                hintText: 'Enter Your City Name',
                                prefixIcon: Icon(
                                  Icons.location_city_rounded,
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
                              'Region',
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
                                  return 'Region Must Not Be Empty';
                                }
                              },
                              controller: regionNameControler,
                              keyboardType: TextInputType.text,
                              cursorColor: defaultColor,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  height: 0,
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                hintText: 'Enter Your Region',
                                prefixIcon: Icon(
                                  Icons.location_searching,
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
                              'Details',
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
                              keyboardType: TextInputType.multiline,
                              minLines: 2,
                              maxLines: 4,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Details Must Not Be Empty';
                                }
                              },
                              controller: detailsNameControler,
                              // keyboardType: TextInputType.text,
                              cursorColor: defaultColor,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  height: 0,
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                hintText: 'Enter Some Details',
                                // prefixIcon: Icon(
                                //   Icons.details_rounded,
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
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                            ),
                            child: const Text(
                              'Notes',
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
                              keyboardType: TextInputType.multiline,
                              minLines: 3,
                              maxLines: 6,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Notes Must Not Be Empty';
                                }
                              },
                              controller: notesNameControler,
                              // keyboardType: TextInputType.text,
                              cursorColor: defaultColor,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  height: 0,
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                hintText: 'Add Some Notes To Help Find You',
                                // prefixIcon: Icon(
                                //   Icons.notes,
                                //   color: Colors.grey[500],
                                // ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                if (addressFormKey.currentState!.validate()) {
                                  if (isEdit) {
                                    MainCubit.get(context).updateAddress(
                                      addressId: addressId,
                                      name: locationNameControler.text,
                                      city: cityNameControler.text,
                                      region: regionNameControler.text,
                                      details: detailsNameControler.text,
                                      notes: notesNameControler.text,
                                    );
                                  } else {
                                    MainCubit.get(context).addAddress(
                                      name: locationNameControler.text,
                                      city: cityNameControler.text,
                                      region: regionNameControler.text,
                                      details: detailsNameControler.text,
                                      notes: notesNameControler.text,
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      if (addressFormKey.currentState!.validate()) {
                        if (isEdit) {
                          MainCubit.get(context).updateAddress(
                            addressId: addressId,
                            name: locationNameControler.text,
                            city: cityNameControler.text,
                            region: regionNameControler.text,
                            details: detailsNameControler.text,
                            notes: notesNameControler.text,
                          );
                        } else {
                          MainCubit.get(context).addAddress(
                            name: locationNameControler.text,
                            city: cityNameControler.text,
                            region: regionNameControler.text,
                            details: detailsNameControler.text,
                            notes: notesNameControler.text,
                          );
                        }
                        // showTopSnackBar(
                        //   context,
                        //   CustomSnackBar.success(
                        //     backgroundColor: Colors.green,
                        //     message: MainCubit.get(context)
                        //         .addAddressModel!
                        //         .message!,
                        //     icon: Icon(null),
                        //   ),
                        // );

                        pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
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
                              Icons.save,
                              color: defaultColor,
                              size: 22,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              'SAVE ADDRESS',
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
        );
      },
    );
  }
}

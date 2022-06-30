import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/addressModels/address_model.dart';
import 'package:shop_app/modules/add&update_address_screen/add&update_address_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';

class AddressesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          // backgroundColor: Colors.grey[50],
          appBar: AppBar(
            centerTitle: true,
            title: Column(
              children: [
                const Text(
                  'Add address',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                if (state is DeleteAddressLoadingState)
                  LinearProgressIndicator(
                    color: defaultColor,
                  ),
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: defaultColor,
              ),
              width: double.infinity,
              height: 40,
              child: TextButton(
                onPressed: () {
                  navigateTo(
                    context,
                    AddAndUpdateAddressScreen(
                      isEdit: false,
                    ),
                  );
                },
                //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                child: const Text(
                  'ADD A NEW ADDRESS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
              ),
            ),
          ),
          body: BuildCondition(
            condition: MainCubit.get(context).addressModel != null,
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
            builder: (context) => BuildCondition(
              condition: state is! GetAddressLoadingState,
              fallback: (context) => Center(
                child: CircularProgressIndicator(
                  color: defaultColor,
                ),
              ),
              builder: (context) => BuildCondition(
                condition:
                    MainCubit.get(context).addressModel!.data!.data!.length !=
                        0,
                fallback: (context) => Center(
                  child: const Text(
                    'No Addresses Found !',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                builder: (context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildAddressItem(
                          MainCubit.get(context)
                              .addressModel!
                              .data!
                              .data![index],
                          context,
                        ),
                        separatorBuilder: (context, index) => Container(),
                        itemCount: MainCubit.get(context)
                            .addressModel!
                            .data!
                            .data!
                            .length,
                      ),
                      // Container(
                      //   color: Colors.white,
                      //   height: 80,
                      //   width: double.infinity,
                      // ),
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

  Widget buildAddressItem(AddressData model, context) => Builder(
        builder: (context) {
          var screenHeight = MediaQuery.of(context).size.height;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10,
            ),
            child: Material(
              shadowColor: Colors.grey[200],
              elevation: 6,
              borderRadius: BorderRadius.circular(
                30,
              ),
              child: Container(
                width: double.infinity,
                height: screenHeight * 0.26,
                decoration: BoxDecoration(
                  //color: Colors.grey[200],
                  // color: white,
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: defaultColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            model.name ?? '',
                            style: Theme.of(context).textTheme.bodyText1!,
                            // style: const TextStyle(
                            //   fontWeight: FontWeight.bold,
                            // ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              MainCubit.get(context)
                                  .deleteAddress(addressId: model.id);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outlined,
                                  color: Colors.grey[400],
                                ),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 20,
                            color: Colors.grey,
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(
                                context,
                                AddAndUpdateAddressScreen(
                                  isEdit: true,
                                  addressId: model.id,
                                  city: model.city,
                                  details: model.details,
                                  name: model.name,
                                  notes: model.notes,
                                  region: model.region,
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: defaultColor,
                                ),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: defaultColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      MyDivider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'City',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Region',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Details',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Notes',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.city ?? '',
                                  style: Theme.of(context).textTheme.bodyText1!,
                                  // style: const TextStyle(
                                  //   //color: Colors.grey[500],
                                  //   fontSize: 16,
                                  // ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  model.region ?? '',
                                  style: Theme.of(context).textTheme.bodyText1!,
                                  // style: const TextStyle(
                                  //   //color: Colors.grey[500],
                                  //   fontSize: 16,
                                  // ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  model.details ?? 'No Details Added',
                                  style: Theme.of(context).textTheme.bodyText1!,
                                  // style: const TextStyle(
                                  //   //color: Colors.grey[500],
                                  //   fontSize: 16,
                                  // ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  model.notes ?? 'No Notes Added',
                                  style: Theme.of(context).textTheme.bodyText1!,
                                  // style: const TextStyle(
                                  //   //color: Colors.grey[500],
                                  //   fontSize: 16,
                                  // ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}

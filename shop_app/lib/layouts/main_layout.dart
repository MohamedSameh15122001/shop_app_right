import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/addresses_screen/addresses_screen.dart';
import 'package:shop_app/modules/complaints_screen/complaint_screen.dart';
import 'package:shop_app/modules/contact_us_screen/contact_us_screen.dart';
import 'package:shop_app/modules/help_screen/help_screen.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/profile_screen/profile_screen.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var cubit = MainCubit.get(context);
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // if (MainCubit.get(context).userModel == null) cubit.getProfileData();
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Shop',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: defaultColor,
                    child: Image(
                      image: AssetImage(
                        'assets/images/logo_2.png',
                      ),
                      color: white,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                const Text(
                  'App',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(
                    context,
                    SearchScreen(),
                  );
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ],
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          drawer: Drawer(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                DrawerHeader(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                      color: defaultColor,
                    ),
                    child: Image(
                      color: white,
                      image: AssetImage(
                        'assets/images/logo_2.png',
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    // && cubit.homeModel != null
                    // state is SuccessHomeModelDataState &&
                    cubit.userModel != null
                        ? MainCubit.get(context).userModel!.data!.name!
                        : 'Welcome',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    // state is SuccessHomeModelDataState &&
                    // state is! SuccessGetProfileModelDataState
                    cubit.userModel != null
                        ? MainCubit.get(context).userModel!.data!.email!
                        : 'buy to get our offers',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        child: const Text(
                          'MY ACCOUNT',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.012,
                      ),
                      ListTile(
                        onTap: () {
                          navigateTo(
                            context,
                            ProfileScreen(),
                          );
                        },
                        leading: const Icon(
                          Icons.person_outline,
                        ),
                        title: const Text(
                          'Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                      MyDivider(),
                      ListTile(
                        hoverColor: defaultColor,
                        onTap: () {
                          navigateTo(
                            context,
                            AddressesScreen(),
                          );
                        },
                        leading: const Icon(
                          Icons.location_on_outlined,
                        ),
                        title: const Text(
                          'Addresses',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.012,
                      ),
                      Container(
                        child: const Text(
                          'SETTINGS',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.012,
                      ),
                      MyDivider(),
                      ListTile(
                        leading: const Icon(
                          Icons.dark_mode_outlined,
                        ),
                        title: const Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Switch(
                          activeColor: defaultColor,
                          onChanged: (value) {
                            MainCubit.get(context).switchValue();
                          },
                          value: MainCubit.get(context).isDark,
                        ),
                      ),
                      MyDivider(),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(
                          Icons.flag_outlined,
                        ),
                        title: Row(
                          children: [
                            const Text(
                              'Country',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.16,
                            ),
                            DropdownButton(
                              items: MainCubit.get(context)
                                  .countryItems
                                  .map((valueItem) {
                                return DropdownMenuItem(
                                  child: Text(valueItem),
                                  value: valueItem,
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                MainCubit.get(context).valueChoose = newValue;
                                MainCubit.get(context).changeCountry();
                              },
                              value: MainCubit.get(context).valueChoose,
                              underline: const SizedBox(),
                            )
                            // Text(
                            //   'Egypt',
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.w400,
                            //     fontSize: 12,
                            //   ),
                            // ),
                          ],
                        ),
                        // trailing: Icon(
                        //   Icons.arrow_forward_ios_rounded,
                        // ),
                      ),
                      MyDivider(),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(
                          Icons.language_outlined,
                        ),
                        title: Row(
                          children: [
                            const Text(
                              'Language',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.133,
                            ),
                            const Text(
                              'English',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.012,
                      ),
                      Container(
                        child: const Text(
                          'REACH OUT TO US',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.012,
                      ),
                      MyDivider(),
                      ListTile(
                        onTap: () {
                          MainCubit.get(context).getFAQ();
                          navigateTo(context, HelpScreen());
                        },
                        leading: const Icon(
                          Icons.info_outline_rounded,
                        ),
                        title: const Text(
                          'FQAs',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                      MyDivider(),
                      ListTile(
                        onTap: () {
                          navigateTo(context, ContactUsScreen());
                        },
                        leading: const Icon(
                          Icons.phone_in_talk_outlined,
                        ),
                        title: const Text(
                          'Contact Us',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                      MyDivider(),
                      ListTile(
                        onTap: () {
                          navigateTo(context, ComplaintScreen());
                        },
                        leading: const Icon(
                          Icons.announcement_outlined,
                        ),
                        title: const Text(
                          'Complaint',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                      MyDivider(),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
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
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                            color: defaultColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.power_settings_new,
                                color: white,
                                size: 22,
                              ),
                              SizedBox(
                                width: screenWidth * 0.015,
                              ),
                              const Text(
                                'SignOut',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNavScreen(index);
            },
            currentIndex: cubit.currentIndex,
            fixedColor: defaultColor,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: const IconThemeData(
              size: 30,
            ),

            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 15,
            ),
            //backgroundColor: white,
            items: const [
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.grid_view_outlined,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.favorite,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                ),
                label: 'Cart',
              ),
            ],
          ),
          drawerScrimColor: Colors.black,
          body: cubit.bottomNavScreens[cubit.currentIndex],
        );
      },
    );
  }
}

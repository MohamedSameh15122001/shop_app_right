import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/main_layout.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/on_boarding_screen/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool onBoarding = CacheHelper.getData('onBoarding') ?? false;
  token = CacheHelper.getData('token');

  // print(token);

  if (onBoarding == true) {
    if (token != null)
      widget = Directionality(
        textDirection: TextDirection.ltr,
        child: MainLayout(),
      );
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(
    MyApp(
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavorites()
        ..getProfileData()
        ..getAddresses()
        ..getCartData(),
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Shop App',
            theme: !MainCubit.get(context).isDark
                ? ThemeData(
                    canvasColor: Colors.white,
                    primaryColor: defaultColor,
                    appBarTheme: const AppBarTheme(
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                      ),
                      iconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                      backgroundColor: white,
                      elevation: 0,
                      //backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: white,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                    ),
                    scaffoldBackgroundColor: white,
                  )
                : ThemeData.dark(),
            // darkTheme: ThemeData(
            //   hintColor: white,
            //   iconTheme: IconThemeData(
            //     color: white,
            //   ),
            //   textTheme: TextTheme(
            //     bodyText1: TextStyle(
            //       color: Colors.white,
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //       height: 1,
            //     ),
            //   ),
            //   primaryColorBrightness: Brightness.dark,
            //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
            //     backgroundColor: HexColor('333739'),
            //     unselectedItemColor: white,
            //   ),
            //   backgroundColor: HexColor('333739'),
            //   primaryColor: defaultColor,
            //   canvasColor: HexColor('333739'),
            //   appBarTheme: AppBarTheme(
            //     titleTextStyle: TextStyle(
            //       color: white,
            //     ),
            //     iconTheme: IconThemeData(
            //       color: white,
            //     ),
            //     backgroundColor: HexColor('333739'),
            //     elevation: 0,
            //     actionsIconTheme: IconThemeData(color: white),
            //     //backwardsCompatibility: false,
            //     systemOverlayStyle: SystemUiOverlayStyle(
            //       statusBarColor: HexColor('333739'),
            //       statusBarIconBrightness: Brightness.light,
            //     ),
            //   ),
            //   scaffoldBackgroundColor: HexColor('333739'),
            // ),
            // themeMode: !MainCubit.get(context).isDark
            //     ? ThemeMode.light
            //     : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            home: splashScreen(),
          );
        },
      ),
    );
  }

  Widget splashScreen() => SplashScreenView(
        navigateRoute: startWidget,
        duration: 4000,
        imageSize: 120,
        imageSrc: "assets/images/splash_image.png",
        text: "  Shop App",
        textType: TextType.ScaleAnimatedText,
        textStyle: const TextStyle(
          fontSize: 38.0,
          color: white,
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: defaultColor,
      );
}

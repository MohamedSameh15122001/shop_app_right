import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  const OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<OnBoardingModel> boardingModel = const [
      OnBoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'WELCOME TO BOARDING',
        body:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      ),
      OnBoardingModel(
          image: 'assets/images/onboard_2.png',
          body:
              'Choose Whatever the Product you wish for with the easiest way possible using ShopMart',
          title: 'Explore'),
      OnBoardingModel(
          image: 'assets/images/onboard_3.png',
          body:
              'Yor Order will be shipped to you as fast as possible by our carrier',
          title: 'Shipping'),
      OnBoardingModel(
          image: 'assets/images/onboard_4.png',
          body:
              'Pay with the safest way possible either by cash or credit cards',
          title: 'Make the Payment'),
    ];

    bool isLast = false;
    var onBoardingController = PageController();

    void submit() {
      CacheHelper.saveData(
        key: 'onBoarding',
        value: true,
      ).then(
        (value) {
          navigateAndFinish(
            context,
            LoginScreen(),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submit,
            child: Text(
              'SKIP',
              style: TextStyle(
                color: defaultColor,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: onBoardingController,
              onPageChanged: (index) {
                if (index == boardingModel.length - 1)
                  isLast = true;
                else
                  isLast = false;
              },
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildBoardingItem(
                context,
                onBoardingController,
                boardingModel[index],
                isLast,
              ),
              itemCount: boardingModel.length,
            ),
          ),
          SmoothPageIndicator(
            controller: onBoardingController,
            effect: const ExpandingDotsEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.deepOrange,
              expansionFactor: 3,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 8,
            ),
            count: 4,
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30,
              ),
              color: defaultColor,
            ),
            child: MaterialButton(
              onPressed: () {
                if (isLast) {
                  submit();
                } else {
                  onBoardingController.nextPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                }
              },
              child: const Icon(
                Icons.forward,
                color: white,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget buildBoardingItem(
    context,
    onBoardingController,
    OnBoardingModel model,
    isLast,
  ) =>
      Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                '${model.image}',
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Title(
                    color: Colors.black,
                    child: Text(
                      '${model.title}'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 340,
                    child: Text(
                      '${model.body}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}

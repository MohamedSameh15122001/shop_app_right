import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/main_layout.dart';
import 'package:shop_app/models/homeModels/products%20_details_model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

late ProductDetailsData model;

class ProductsDetailsScreen extends StatelessWidget {
  const ProductsDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productDetailsImages = PageController();
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is SuccessChangeFavoritesModelDataState) {
          if (!state.model.status!) {
            // showToast(
            //   message: state.model.message!,
            //   state: ToastStates.ERROR,
            // );
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                backgroundColor: Colors.red,
                message: state.model.message!,
                icon: Icon(null),
              ),
            );
          } else {
            // showToast(
            //   message: state.model.message!,
            //   state: ToastStates.SUCCESS,
            // );
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                backgroundColor: Colors.green,
                message: state.model.message!,
                icon: Icon(null),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        if (MainCubit.get(context).productDetailsModel != null) {
          model = MainCubit.get(context).productDetailsModel!.data!;
        }

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text(
              'Products Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: BuildCondition(
            condition: MainCubit.get(context).productDetailsModel != null,
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
            builder: (context) => BuildCondition(
              condition: state is! GetProductsLoadingState,
              fallback: (context) => Center(
                child: CircularProgressIndicator(
                  color: defaultColor,
                ),
              ),
              builder: (context) => Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 400,
                            width: double.infinity,
                            child: PageView.builder(
                              controller: productDetailsImages,
                              itemBuilder: (context, index) => Image(
                                image: NetworkImage('${model.images![index]}'),
                              ),
                              itemCount: model.images!.length,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SmoothPageIndicator(
                            controller: productDetailsImages,
                            count: model.images!.length,
                            effect: const ExpandingDotsEffect(
                                dotColor: Colors.grey,
                                activeDotColor: Colors.deepOrange,
                                expansionFactor: 4,
                                dotHeight: 7,
                                dotWidth: 10,
                                spacing: 10),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                  '${model.name}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'EGP '
                                            '' +
                                        '${model.price}',
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      MainCubit.get(context)
                                          .changeFavorites(model.id);
                                    },
                                    icon: Icon(
                                      MainCubit.get(context)
                                              .favorites[model.id]!
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      color: defaultColor,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              if (model.discount != 0)
                                Row(
                                  children: [
                                    Text(
                                      'EGP' + '${model.oldPrice}',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${model.discount}% OFF',
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              if (model.discount != 0)
                                const SizedBox(
                                  height: 15,
                                ),
                              MyDivider(),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: const [
                                  Text(
                                    'FREE delivery by ',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Text('${getDateTomorrow()}'),
                                  Text('30 sep'),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Order in 19h 16m',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              MyDivider(),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text('Offer Details',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.check_circle_outline,
                                      color: Colors.green),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Enjoy free returns with this offer'),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              MyDivider(),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.check_circle_outline,
                                      color: Colors.green),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('2 Year warranty'),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              MyDivider(),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Sold by ShopApp'),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              MyDivider(),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text('Overview',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 15,
                              ),
                              Text('${model.description}'),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Container(
                            height: 40,
                            width: double.infinity,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (MainCubit.get(context).cart[model.id]) {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.success(
                                backgroundColor: Colors.blue,
                                message:
                                    'Already in Your Cart \nCheck your cart To Edit or Delete ',
                                icon: Icon(null),
                              ),
                            );
                            // showToast(
                            //   message:
                            //       'Already in Your Cart \nCheck your cart To Edit or Delete ',
                            //   state: ToastStates.WARNING,
                            // );
                          } else {
                            MainCubit.get(context).addToCart(model.id);
                            scaffoldKey.currentState!.showBottomSheet(
                              (context) => Container(
                                color: Colors.grey[300],
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${model.name}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Text(
                                                'Added to Cart',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'CONTINUE SHOPPING',
                                              style: TextStyle(
                                                color: defaultColor,
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: defaultColor,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          height: 36,
                                          child: TextButton(
                                            onPressed: () {
                                              navigateTo(context, MainLayout());
                                              MainCubit.get(context)
                                                  .currentIndex = 3;
                                            },
                                            child: const Text(
                                              'CHECKOUT',
                                              style: TextStyle(
                                                color: white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              elevation: 50,
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: white,
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

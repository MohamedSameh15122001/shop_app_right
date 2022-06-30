import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoriesModels/categories_model.dart';
import 'package:shop_app/models/homeModels/home_model.dart';
import 'package:shop_app/modules/categories_details_screen/categories_details_screen.dart';
import 'package:shop_app/modules/products_details_screen/products_details_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = MainCubit.get(context);
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
        internetConection(context);
        return BuildCondition(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: defaultColor,
            ),
          ),
          builder: (context) => productsBuilder(
            cubit.homeModel,
            cubit.categoriesModel,
            context,
          ),
        );
      },
    );
  }

  Widget productsBuilder(
    HomeModel? model,
    CategoriesModel? categoriesModel,
    context,
  ) =>
      Builder(builder: (context) {
        var screenHeight = MediaQuery.of(context).size.height;

        return Scaffold(
          //backgroundColor: Colors.grey[200],
          // backgroundColor: white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: model!.data!.banners
                      .map(
                        (element) => Image(
                          errorBuilder: (
                            BuildContext context,
                            Object exception,
                            StackTrace? stackTrace,
                          ) =>
                              const Text('😢'),
                          image: NetworkImage(
                            '${element.image ?? 'https://static.thenounproject.com/png/741653-200.png'}',
                          ),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(
                      seconds: 3,
                    ),
                    autoPlayAnimationDuration: const Duration(
                      seconds: 1,
                    ),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1,
                  ),
                ),
                Container(
                  height: screenHeight * 0.225,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategoriesItem(
                      categoriesModel!.data.data[index],
                      context,
                    ),
                    separatorBuilder: (context, index) => const Center(),
                    itemCount: categoriesModel!.data.data.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 2,
                    left: 16,
                    right: 16,
                  ),
                  child: GridView.count(
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1 / (screenHeight * 0.0024),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(
                        model.data!.products.length,
                        (index) => buildGridProduct(
                              model.data!.products[index],
                              context,
                            )),
                  ),
                ),
              ],
            ),
          ),
        );
      });

  Widget buildGridProduct(HomeProductModel model, context) =>
      Builder(builder: (context) {
        var screenHeight = MediaQuery.of(context).size.height;
        var screenWidth = MediaQuery.of(context).size.width;
        return InkWell(
          highlightColor: white,
          onTap: () {
            MainCubit.get(context).getProductsDetails(model.id);
            navigateTo(context, ProductsDetailsScreen());
          },
          child: Material(
            shadowColor: Colors.grey[200],
            elevation: 6,
            borderRadius: BorderRadius.circular(
              30,
            ),
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.grey[200],
                // color: white,
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image(
                          errorBuilder: (
                            BuildContext context,
                            Object exception,
                            StackTrace? stackTrace,
                          ) =>
                              const Text('😢'),
                          image: NetworkImage(
                            model.image ??
                                'https://static.thenounproject.com/png/741653-200.png',
                          ),
                          height: 200,
                          width: 200,
                          // fit: BoxFit.contain,
                        ),
                        if (model.discount != 0)
                          Image(
                            errorBuilder: (
                              BuildContext context,
                              Object exception,
                              StackTrace? stackTrace,
                            ) =>
                                const Text('😢'),
                            image: const AssetImage(
                              'assets/images/discount.png',
                            ),
                            height: 40,
                            width: 40,
                          ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.013,
                    ),
                    Text(model.name ?? 'error Title',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1!

                        // style: const TextStyle(
                        //   fontSize: 16,
                        //   fontWeight: FontWeight.bold,
                        //   //height: 1,
                        // ),
                        ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${model.price.round()}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: defaultColor,
                            //height: 1,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.01,
                        ),
                        if (model.discount != 0)
                          Text(
                            'EGP ${model.oldPrice.round()}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              //height: 1,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            MainCubit.get(context).changeFavorites(model.id);
                          },
                          icon: Icon(
                            MainCubit.get(context).favorites[model.id]!
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: defaultColor,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.075,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });

  Widget buildCategoriesItem(DataModel model, context) =>
      Builder(builder: (context) {
        var screenHeight = MediaQuery.of(context).size.height;

        return InkWell(
          highlightColor: white,
          onTap: () {
            MainCubit.get(context).getCategoriesDetails(model.id);
            navigateTo(context, CategoriesDetailsScreen(model.name));
          },
          child: Padding(
            padding: const EdgeInsets.only(
              right: 2,
              top: 16,
              bottom: 16,
              left: 16,
            ),
            child: Material(
              shadowColor: Colors.grey[200],
              elevation: 6,
              borderRadius: BorderRadius.circular(
                30,
              ),
              child: Container(
                decoration: BoxDecoration(
                  // color: white,
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image(
                        errorBuilder: (
                          BuildContext context,
                          Object exception,
                          StackTrace? stackTrace,
                        ) =>
                            const Text('😢'),
                        image: NetworkImage(
                          model.image ??
                              'https://static.thenounproject.com/png/741653-200.png',
                        ),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: screenHeight * 0.012,
                      ),
                      Text(model.name ?? 'error title',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1!
                          // style: const TextStyle(
                          //   fontWeight: FontWeight.w500,
                          // ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}

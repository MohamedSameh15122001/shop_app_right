import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/products_details_screen/products_details_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 6,
            title: state is LoadingChangeFavoritesModelDataState ||
                    state is AddCartLoadingState
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        child: LinearProgressIndicator(
                          color: defaultColor,
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),

          //backgroundColor: Colors.grey[50],
          body: BuildCondition(
            condition: MainCubit.get(context).favoritesModel != null,
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
            builder: (context) => BuildCondition(
              condition: state is! LoadingGetFavoritesModelDataState,
              fallback: (context) => Center(
                child: CircularProgressIndicator(
                  color: defaultColor,
                ),
              ),
              builder: (context) => BuildCondition(
                condition:
                    MainCubit.get(context).favoritesModel!.data.data.length ==
                        0,
                fallback: (context) => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildFavItem(
                      MainCubit.get(context)
                          .favoritesModel!
                          .data
                          .data[index]
                          .product,
                      context,
                      state),
                  separatorBuilder: (context, index) => const Center(),
                  itemCount:
                      MainCubit.get(context).favoritesModel!.data.data.length,
                ),
                builder: (context) => const Center(
                  child: Text(
                    'No Favorites Data!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildFavItem(model, context, state, {bool isOldPrice = true}) =>
      InkWell(
        highlightColor: white,
        onTap: () {
          MainCubit.get(context).getProductsDetails(model.id);
          navigateTo(context, ProductsDetailsScreen());
        },
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 4,
            right: 20,
            left: 20,
            top: 20,
          ),
          child: Material(
            shadowColor: Colors.grey[200],
            elevation: 6,
            borderRadius: BorderRadius.circular(
              30,
            ),
            child: Container(
              height: 190,
              decoration: BoxDecoration(
                // color: white,
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    // if (state is! LoadingGetFavoritesModelDataState)
                    //   LinearProgressIndicator(
                    //     color: defaultColor,
                    //   ),
                    Column(
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
                          width: 120,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            MainCubit.get(context).changeFavorites(model.id);
                            MainCubit.get(context).addToCart(model.id);
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Add To Cart',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.name!,
                            style: Theme.of(context).textTheme.bodyText1!,
                            // style: const TextStyle(
                            //   fontSize: 14,
                            // ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${model.price.toString()} EGP',
                            style: TextStyle(
                              fontSize: 18,
                              color: defaultColor,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (model.discount != 0 && isOldPrice)
                            Text(
                              model.oldPrice.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              MainCubit.get(context).changeFavorites(model.id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Remove',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

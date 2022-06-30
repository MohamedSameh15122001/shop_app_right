import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoriesModels/categories_details_model.dart';
import 'package:shop_app/modules/products_details_screen/products_details_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';

class CategoriesDetailsScreen extends StatelessWidget {
  final String? categoryName;
  const CategoriesDetailsScreen(
    this.categoryName, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '$categoryName',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: BuildCondition(
            condition: MainCubit.get(context).categoryDetailModel != null,
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
            builder: (context) => BuildCondition(
              condition: state is! GetCategoriesLoadingState,
              fallback: (context) => Center(
                child: CircularProgressIndicator(
                  color: defaultColor,
                ),
              ),
              builder: (context) => MainCubit.get(context)
                          .categoryDetailModel!
                          .data
                          .productData
                          .length ==
                      0
                  ? const Center(
                      child: Text(
                        'Coming Soon !',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                        bottom: 2,
                        left: 16,
                        right: 16,
                      ),
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1 / 1.888888888888,
                        crossAxisCount: 2,
                        children: List.generate(
                          MainCubit.get(context)
                              .categoryDetailModel!
                              .data
                              .productData
                              .length,
                          (index) => buildCategoriesDetails(
                            MainCubit.get(context)
                                .categoryDetailModel!
                                .data
                                .productData[index],
                            context,
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

  Widget buildCategoriesDetails(
    ProductData model,
    context,
  ) =>
      InkWell(
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
              //color: Colors.grey[200],
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
                right: 8.0,
                bottom: 0.0,
              ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    model.name ?? 'error Title',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      //height: 1,
                    ),
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
                      const SizedBox(
                        width: 8,
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
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoriesModels/categories_model.dart';
import 'package:shop_app/modules/categories_details_screen/categories_details_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  Future<Null> refresh(context) async {
    print('loading');
    await Future.delayed(Duration(seconds: 3));
    MainCubit.get(context).getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = MainCubit.get(context);
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          condition: cubit.categoriesModel != null,
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: defaultColor,
            ),
          ),
          builder: (context) => Scaffold(
            //backgroundColor: Colors.grey[50],
            body: RefreshIndicator(
              onRefresh: () async {
                await refresh(context);
              },
              color: defaultColor,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                // parent: AlwaysScrollableScrollPhysics()
                itemBuilder: (context, index) => buildCatItem(
                    cubit.categoriesModel!.data.data[index], context),
                separatorBuilder: (context, index) => const Center(),
                itemCount: cubit.categoriesModel!.data.data.length,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCatItem(DataModel model, context) => InkWell(
        highlightColor: white,
        onTap: () {
          MainCubit.get(context).getCategoriesDetails(model.id);
          navigateTo(context, CategoriesDetailsScreen(model.name));
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
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(model.name ?? 'error title',
                        style: Theme.of(context).textTheme.bodyText1!
                        // style: const TextStyle(
                        //   fontSize: 20,
                        //   fontWeight: FontWeight.bold,
                        // ),
                        ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

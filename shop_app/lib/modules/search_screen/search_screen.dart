import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/products_details_screen/products_details_screen.dart';
import 'package:shop_app/modules/search_screen/search_cubit.dart';
import 'package:shop_app/modules/search_screen/search_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchFromKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: defaultColor,
                  child: const Image(
                    image: AssetImage(
                      'assets/images/logo_2.png',
                    ),
                    color: white,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              centerTitle: true,
            ),
            body: Form(
              key: searchFromKey,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        child: TextFormField(
                          autofocus: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Search Is Empty!';
                            }
                          },
                          cursorColor: defaultColor,
                          controller: searchController,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(
                              height: 0,
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 30.0, 20.0, 10.0),
                            hintText: 'Search',
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[500],
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onChanged: (value) {
                            internetConection(context);
                            SearchCubit.get(context).getSearch(value);
                          },
                          onFieldSubmitted: (value) {
                            internetConection(context);
                            // SearchCubit.get(context).getSearch(value);
                          },
                        ),
                      ),
                    ),
                    if (state is SearchLoadingState)
                      Padding(
                        padding: const EdgeInsets.all(
                          20,
                        ),
                        child: LinearProgressIndicator(
                          color: defaultColor,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildSearchItem(
                            SearchCubit.get(context)
                                .searchModel!
                                .data
                                .data[index],
                            context,
                            state,
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => const Center(),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data
                              .data
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(model, context, state, {bool isOldPrice = true}) =>
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
              height: 160,
              decoration: BoxDecoration(
                color: white,
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
                          image: NetworkImage(
                            model.image ??
                                'https://static.thenounproject.com/png/741653-200.png',
                          ),
                          width: 120,
                          height: 120,
                          fit: BoxFit.contain,
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
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${model.price.toString()} EGP',
                            style: const TextStyle(
                              fontSize: 20,
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

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/cartModels/get_cart_model.dart';
import 'package:shop_app/modules/products_details_screen/products_details_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';

// String getDateTomorrow() {
//   DateTime dateTime = DateTime.now().add(Duration(days: 1));
//   String date = DateFormat.yMMMd().format(dateTime);
//   return date;
// }

TextEditingController counterController = TextEditingController();
int cartLength = 0;
late CartModel cartModel;

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (MainCubit.get(context).cartModel != null) {
          cartModel = MainCubit.get(context).cartModel!;
          cartLength = MainCubit.get(context).cartModel!.data!.cartItems.length;
        }
        return BuildCondition(
          condition: MainCubit.get(context).cartModel != null,
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: defaultColor,
            ),
          ),
          builder: (context) => BuildCondition(
            condition:
                MainCubit.get(context).cartModel!.data!.cartItems.length != 0,
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 70,
                    color: Colors.greenAccent,
                  ),
                  SizedBox(
                    height: screenHeight * 0.013,
                  ),
                  const Text(
                    'Your Cart is empty',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                      'Be Sure to fill your cart with something you like',
                      style: TextStyle(fontSize: 15))
                ],
              ),
            ),
            builder: (context) => Scaffold(
              appBar: AppBar(
                toolbarHeight: 6,
                title: state is UpdateCartLoadingState ||
                        state is LoadingChangeFavoritesModelDataState
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LinearProgressIndicator(
                            color: defaultColor,
                          ),
                        ],
                      )
                    : Container(),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => cartProducts(
                            MainCubit.get(context)
                                .cartModel!
                                .data!
                                .cartItems[index],
                            context),
                        separatorBuilder: (context, index) => MyDivider(),
                        itemCount: cartLength),
                    Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Subtotal' + '($cartLength Items)',
                                  style: const TextStyle(color: Colors.grey)),
                              const Spacer(),
                              Text('EGP ' + '${cartModel.data!.subTotal}',
                                  style: const TextStyle(color: Colors.grey))
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.019,
                          ),
                          Row(
                            children: const [
                              Text('Shipping Fee'),
                              Spacer(),
                              Text(
                                'Free',
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.025,
                          ),
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              const Text('TOTAL',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const Text(
                                ' Inclusive of VAT',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic),
                              ),
                              const Spacer(),
                              Text('EGP ' + '${cartModel.data!.total}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   width: double.infinity,
                    //   height: 0,
                    //   color: Colors.white,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget cartProducts(CartItems? model, context) {
    counterController.text = '${model!.quantity}';
    return Builder(builder: (context) {
      var screenHeight = MediaQuery.of(context).size.height;
      var screenWidth = MediaQuery.of(context).size.width;
      return InkWell(
        onTap: () {
          MainCubit.get(context).getProductsDetails(model.product!.id);
          navigateTo(context, ProductsDetailsScreen());
        },
        child: Container(
          height: screenHeight * 0.23,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                // color: white,
                height: screenHeight * 0.13,
                child: Row(
                  children: [
                    Image(
                      image: NetworkImage('${model.product!.image}'),
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(
                      width: screenWidth * 0.025,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${model.product!.name}',
                            style: Theme.of(context).textTheme.bodyText1!,
                            // style: const TextStyle(
                            //   fontSize: 15,
                            // ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          Text(
                            'EGP ' + '${model.product!.price}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: defaultColor),
                          ),
                          // if (model.product!.discount != 0)
                          //   SizedBox(
                          //     height: screenHeight * 0.01,
                          //   ),
                          if (model.product!.discount != 0)
                            Text(
                              'EGP' + '${model.product!.oldPrice}',
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    child: MaterialButton(
                      onPressed: () {
                        int quantity = model.quantity! - 1;
                        if (quantity != 0)
                          MainCubit.get(context)
                              .updateCartData(model.id, quantity);
                      },
                      child: const Icon(
                        Icons.remove,
                        size: 17,
                        color: Colors.deepOrange,
                      ),
                      minWidth: 20,
                      //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.013,
                  ),
                  Text(
                    '${model.quantity}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: screenWidth * 0.013,
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    child: MaterialButton(
                      onPressed: () {
                        int quantity = model.quantity! + 1;
                        if (quantity <= 5)
                          MainCubit.get(context)
                              .updateCartData(model.id, quantity);
                      },
                      child: Icon(
                        Icons.add,
                        size: 17,
                        color: Colors.green[500],
                      ),
                      minWidth: 10,
                      //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      MainCubit.get(context).addToCart(model.product!.id);
                      MainCubit.get(context).changeFavorites(model.product!.id);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.grey,
                          size: 18,
                        ),
                        SizedBox(
                          width: screenWidth * 0.0067,
                        ),
                        const Text(
                          'Move to Wishlist',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.013,
                  ),
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.grey[300],
                  ),
                  TextButton(
                      onPressed: () {
                        MainCubit.get(context).addToCart(model.product!.id);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.grey,
                            size: 18,
                          ),
                          SizedBox(
                            width: screenWidth * 0.0067,
                          ),
                          const Text('Remove',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              )),
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

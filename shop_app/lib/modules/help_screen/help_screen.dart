import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/profileModels/faqs_models.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/main_cubit/main_cubit.dart';
import 'package:shop_app/shared/main_cubit/states.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          // backgroundColor: white,
          appBar: AppBar(
            title: const Text(
              'FAQs',
              style: TextStyle(fontSize: 20),
            ),
          ),
          // backgroundColor: Colors.grey[50],
          body: BuildCondition(
            condition: MainCubit.get(context).faqsModel != null,
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
            builder: (context) => BuildCondition(
              condition: state is! LoadingGetFAQModelDataState,
              fallback: (context) => Center(
                child: CircularProgressIndicator(
                  color: defaultColor,
                ),
              ),
              builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, int index) => buildFQAItem(
                    MainCubit.get(context).faqsModel!.data!.data![index],
                    context),
                separatorBuilder: (context, index) => const Center(),
                itemCount: MainCubit.get(context).faqsModel!.data!.data!.length,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildFQAItem(FAQsData model, context) => Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          right: 20,
          left: 20,
          top: 10,
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
              // color: white,
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.question!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 22),
                    // style: const TextStyle(
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: 22,
                    // ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    model.answer ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 15),
                    // style: const TextStyle(
                    //   fontSize: 16,
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

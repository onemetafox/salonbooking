/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_user/app/controller/categories_controller.dart';
import 'package:salon_user/app/controller/product_cart_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Categories'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          bottomNavigationBar: Get.find<ProductCartController>()
                  .savedInCart
                  .isNotEmpty
              ? SizedBox(
                  height: 50,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            value.onCart();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                              color: ThemeProvider.appColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  value.currencySide == 'left'
                                      ? '${Get.find<ProductCartController>().savedInCart.length} ${'Items'.tr} ${value.currencySymbol} ${Get.find<ProductCartController>().totalPrice}'
                                      : ' ${Get.find<ProductCartController>().savedInCart.length} ${'Items'.tr} ${Get.find<ProductCartController>().totalPrice}${value.currencySymbol}',
                                  style: const TextStyle(
                                      color: ThemeProvider.whiteColor),
                                ),
                                Text(
                                  'Payments'.tr,
                                  style: const TextStyle(
                                      color: ThemeProvider.whiteColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
          body: value.apiCalled == false
              ? SkeletonListView()
              : value.productsList.isNotEmpty
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Column(
                              children: List.generate(
                                value.productsList.length,
                                (index) => Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 150,
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: FadeInImage(
                                            image: NetworkImage(
                                                '${Environments.apiBaseURL}storage/images/${value.productsList[index].cover.toString()}'),
                                            placeholder: const AssetImage(
                                                "assets/images/placeholder.jpeg"),
                                            imageErrorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  'assets/images/notfound.png',
                                                  fit: BoxFit.cover);
                                            },
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: InkWell(
                                            onTap: () {
                                              value.onCategoryExpand(value
                                                  .productsList[index].id
                                                  .toString());
                                            },
                                            child: Container(
                                              height: 150,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: ThemeProvider.blackColor
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      value.productsList[index]
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: ThemeProvider
                                                              .whiteColor,
                                                          fontSize: 17),
                                                    ),
                                                    Icon(
                                                        value.selectedCategory ==
                                                                value
                                                                    .productsList[
                                                                        index]
                                                                    .id
                                                                    .toString()
                                                            ? Icons
                                                                .keyboard_arrow_down
                                                            : Icons
                                                                .keyboard_arrow_up,
                                                        color: Colors.white),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    value.selectedCategory ==
                                            value.productsList[index].id
                                                .toString()
                                        ? Column(
                                            children: List.generate(
                                              value.productsList[index]
                                                  .subCates!.length,
                                              (subIndex) => Column(
                                                children: [
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color: ThemeProvider
                                                                .greyColor),
                                                      ),
                                                    ),
                                                    child: ListTile(
                                                      onTap: () {
                                                        value.onProducts(
                                                          value
                                                              .productsList[
                                                                  index]
                                                              .id as int,
                                                          value
                                                              .productsList[
                                                                  index]
                                                              .subCates![
                                                                  subIndex]
                                                              .id as int,
                                                        );
                                                      },
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 10),
                                                      title: Text(
                                                        value
                                                            .productsList[index]
                                                            .subCates![subIndex]
                                                            .name
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.asset(
                            "assets/images/no-data.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                            'No Data Found!'.tr,
                            style: const TextStyle(fontFamily: 'bold'),
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }
}

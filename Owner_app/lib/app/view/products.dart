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
import 'package:ultimate_salon_owner_flutter/app/controller/products_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 50,
            title: Text(
              'Products'.tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: ThemeProvider.titleStyle,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: ThemeProvider.blackColor,
                    backgroundColor: ThemeProvider.greenColor,
                    textStyle: const TextStyle(fontSize: 10),
                  ),
                  onPressed: () {
                    value.onCreateProducts();
                  },
                  child: Text(
                    'Add New'.tr,
                    style: const TextStyle(
                        color: ThemeProvider.whiteColor, fontFamily: 'bold'),
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      style: const TextStyle(color: ThemeProvider.blackColor),
                      decoration: InputDecoration(
                        hintText: 'Search for Salon, Services....'.tr,
                        prefixIcon: const Icon(Icons.search),
                        hintStyle:
                            const TextStyle(color: ThemeProvider.greyColor),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: ThemeProvider.whiteColor,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: ThemeProvider.transparent,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: ThemeProvider.transparent,
                          ),
                        ),
                        filled: true,
                        fillColor: ThemeProvider.whiteColor,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        for (var item in value.productsInfo)
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ThemeProvider.whiteColor,
                              boxShadow: const [
                                BoxShadow(
                                    color: ThemeProvider.greyColor,
                                    blurRadius: 5.0,
                                    offset: Offset(0.7, 2.0)),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(40),
                                    child: FadeInImage(
                                      image: NetworkImage(
                                          '${Environments.apiBaseURL}storage/images/${item.cover.toString()}'),
                                      placeholder: const AssetImage(
                                          "assets/images/placeholder.jpeg"),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/notfound.png',
                                          fit: BoxFit.cover,
                                          height: 40,
                                          width: 40,
                                        );
                                      },
                                      fit: BoxFit.cover,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.name.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontFamily: 'bold',
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  value.updateStatus(
                                                      item.id as int,
                                                      item.status as int);
                                                },
                                                child: Icon(
                                                  item.status == 1
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: item.status == 1
                                                      ? ThemeProvider.greenColor
                                                      : ThemeProvider
                                                          .blackColor,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              InkWell(
                                                onTap: () {
                                                  value.onUpdateProducts(
                                                      item.id as int);
                                                },
                                                child: const Icon(
                                                  Icons.edit_note,
                                                  color: ThemeProvider.appColor,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Image.asset(
                                                                'assets/images/delete.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 80,
                                                                width: 80,
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                'Are you sure'
                                                                    .tr,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        24,
                                                                    fontFamily:
                                                                        'semi-bold'),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                  'to delete Slots ?'
                                                                      .tr),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        foregroundColor:
                                                                            ThemeProvider.backgroundColor,
                                                                        backgroundColor:
                                                                            ThemeProvider.redColor,
                                                                        minimumSize:
                                                                            const Size.fromHeight(35),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        'Cancel'
                                                                            .tr,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ThemeProvider.whiteColor,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        value.destroyProduct(item.id
                                                                            as int);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        foregroundColor:
                                                                            ThemeProvider.backgroundColor,
                                                                        backgroundColor:
                                                                            ThemeProvider.greenColor,
                                                                        minimumSize:
                                                                            const Size.fromHeight(35),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        'Delete'
                                                                            .tr,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ThemeProvider.whiteColor,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                  color: ThemeProvider.redColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: Get.find<ProductsController>()
                                                          .currencySide ==
                                                      'left'
                                                  ? '${Get.find<ProductsController>().currencySymbol}  ${item.originalPrice.toString()}'
                                                  : '  ${item.originalPrice.toString()}${Get.find<ProductsController>().currencySymbol}',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      ThemeProvider.greyColor,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                            TextSpan(
                                              text: Get.find<ProductsController>()
                                                          .currencySide ==
                                                      'left'
                                                  ? '${Get.find<ProductsController>().currencySymbol}  ${item.sellPrice.toString()}'
                                                  : '  ${item.sellPrice.toString()}${Get.find<ProductsController>().currencySymbol}',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      ThemeProvider.greenColor,
                                                  fontFamily: 'bold'),
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
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

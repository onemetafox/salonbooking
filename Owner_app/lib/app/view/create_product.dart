/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/create_products_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class CreateProductsScreen extends StatefulWidget {
  const CreateProductsScreen({Key? key}) : super(key: key);

  @override
  State<CreateProductsScreen> createState() => _CreateProductsScreenState();
}

class _CreateProductsScreenState extends State<CreateProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateProductsController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 50,
            title: Text(
              value.type == 'create'
                  ? 'Create Products'.tr
                  : 'Update Products'.tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == true
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoActionSheet(
                                title: Text('Choose From'.tr),
                                actions: <CupertinoActionSheetAction>[
                                  CupertinoActionSheetAction(
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      value.selectFromGallery('camera');
                                    },
                                    child: Text('Camera'.tr),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      value.selectFromGallery('gallery');
                                    },
                                    child: Text('Gallery'.tr),
                                  ),
                                  CupertinoActionSheetAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'.tr),
                                  )
                                ],
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(70),
                              child: FadeInImage(
                                image: NetworkImage(
                                    '${Environments.apiBaseURL}storage/images/${value.cover}'),
                                placeholder: const AssetImage(
                                    "assets/images/placeholder.jpeg"),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/notfound.png',
                                    fit: BoxFit.cover,
                                    height: 70,
                                    width: 70,
                                  );
                                },
                                fit: BoxFit.cover,
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  color: Colors.grey, style: BorderStyle.solid),
                            ),
                            child: InkWell(
                              onTap: () {
                                value.onShopCategories();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Categories'.tr,
                                      style: const TextStyle(
                                          color: ThemeProvider.greyColor,
                                          fontSize: 14),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        value.selectedCateName == ''
                                            ? Text(
                                                'Select Categories'.tr,
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              )
                                            : Text(value.selectedCateName,
                                                style: const TextStyle(
                                                    fontSize: 17)),
                                        const Icon(
                                          Icons.expand_more,
                                          color: ThemeProvider.greyColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  color: Colors.grey, style: BorderStyle.solid),
                            ),
                            child: InkWell(
                              onTap: () {
                                value.onShopSubCategories();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Select Subcategories'.tr,
                                      style: const TextStyle(
                                          color: ThemeProvider.greyColor,
                                          fontSize: 14),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        value.selectedSubName == ''
                                            ? Text(
                                                'Sub Categories'.tr,
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              )
                                            : Text(
                                                value.selectedSubName,
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                        const Icon(
                                          Icons.expand_more,
                                          color: ThemeProvider.greyColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: value.productNameTextEditor,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeProvider.whiteColor,
                                hintText: 'Products Name'.tr,
                                contentPadding: const EdgeInsets.only(
                                    bottom: 8.0, top: 14.0, left: 10),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ThemeProvider.appColor),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeProvider.greyColor)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: value.productsPriceTextEditor,
                              onChanged: (String txt) {
                                value.onRealPrice(txt);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeProvider.whiteColor,
                                hintText: 'Products Price'.tr,
                                contentPadding: const EdgeInsets.only(
                                    bottom: 8.0, top: 14.0, left: 10),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ThemeProvider.appColor),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeProvider.greyColor)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: value.discountTextEditor,
                              onChanged: (String txt) {
                                value.onDiscountPrice(txt);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeProvider.whiteColor,
                                hintText: 'Discount %'.tr,
                                contentPadding: const EdgeInsets.only(
                                    bottom: 8.0, top: 14.0, left: 10),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ThemeProvider.appColor),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeProvider.greyColor)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: value.sellPriceTextEditor,
                              decoration: InputDecoration(
                                filled: true,
                                enabled: false,
                                disabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeProvider.greyColor)),
                                fillColor: ThemeProvider.whiteColor,
                                hintText: 'Sell Price'.tr,
                                contentPadding: const EdgeInsets.only(
                                    bottom: 8.0, top: 14.0, left: 10),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ThemeProvider.appColor),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeProvider.greyColor)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  color: Colors.grey, style: BorderStyle.solid),
                            ),
                            child: InkWell(
                              onTap: () {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoActionSheet(
                                    title: Text(
                                      'Choose From'.tr,
                                      style: const TextStyle(
                                          fontFamily: 'bold',
                                          color: ThemeProvider.blackColor,
                                          fontSize: 14),
                                    ),
                                    actions: <CupertinoActionSheetAction>[
                                      CupertinoActionSheetAction(
                                        child: Text(
                                          'Available'.tr,
                                          style: const TextStyle(
                                              color: ThemeProvider.appColor,
                                              fontSize: 15),
                                        ),
                                        onPressed: () {
                                          value.updateOfferStatus(1);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoActionSheetAction(
                                        child: Text(
                                          'Hide'.tr,
                                          style: const TextStyle(
                                              color: ThemeProvider.appColor,
                                              fontSize: 15),
                                        ),
                                        onPressed: () {
                                          value.updateOfferStatus(0);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoActionSheetAction(
                                        child: Text(
                                          'Cancel'.tr,
                                          style: const TextStyle(
                                              fontFamily: 'bold',
                                              color: ThemeProvider.redColor,
                                              fontSize: 14),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'in Offers'.tr,
                                      style: const TextStyle(
                                          color: ThemeProvider.greyColor,
                                          fontSize: 14),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          value.selectedOfferStatus == 1
                                              ? 'Available'.tr
                                              : 'Hide'.tr,
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                        const Icon(
                                          Icons.expand_more,
                                          color: ThemeProvider.greyColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  color: Colors.grey, style: BorderStyle.solid),
                            ),
                            child: InkWell(
                              onTap: () {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoActionSheet(
                                    title: Text(
                                      'Choose From'.tr,
                                      style: const TextStyle(
                                          fontFamily: 'bold',
                                          color: ThemeProvider.blackColor,
                                          fontSize: 14),
                                    ),
                                    actions: <CupertinoActionSheetAction>[
                                      CupertinoActionSheetAction(
                                        child: Text(
                                          'Available'.tr,
                                          style: const TextStyle(
                                              color: ThemeProvider.appColor,
                                              fontSize: 15),
                                        ),
                                        onPressed: () {
                                          value.updateStackStatus(1);

                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoActionSheetAction(
                                        child: Text(
                                          'Hide'.tr,
                                          style: const TextStyle(
                                              color: ThemeProvider.appColor,
                                              fontSize: 15),
                                        ),
                                        onPressed: () {
                                          value.updateStackStatus(0);

                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoActionSheetAction(
                                        child: Text(
                                          'Cancel'.tr,
                                          style: const TextStyle(
                                              fontFamily: 'bold',
                                              color: ThemeProvider.redColor,
                                              fontSize: 14),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'in Stock'.tr,
                                      style: const TextStyle(
                                          color: ThemeProvider.greyColor,
                                          fontSize: 14),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          value.selectedStackStatus == 1
                                              ? 'Available'.tr
                                              : 'Hide'.tr,
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                        const Icon(
                                          Icons.expand_more,
                                          color: ThemeProvider.greyColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ThemeProvider.whiteColor,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: ThemeProvider.greyColor,
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SwitchListTile(
                                  title: Text('in Home'.tr),
                                  value: value.inHome,
                                  activeColor: ThemeProvider.greenColor,
                                  onChanged: (bool status) {
                                    value.updateinHome(status);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ThemeProvider.whiteColor,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: ThemeProvider.greyColor,
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SwitchListTile(
                                  title: Text('in Single'.tr),
                                  value: value.inSingle,
                                  activeColor: ThemeProvider.greenColor,
                                  onChanged: (bool status) {
                                    value.updateinSingle(status);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                'Upload More Image'.tr,
                                style: const TextStyle(
                                    fontFamily: 'bold', fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: GridView.count(
                            primary: false,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            shrinkWrap: true,
                            childAspectRatio: 100 / 100,
                            padding: EdgeInsets.zero,
                            children: List.generate(
                              value.gallery.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CupertinoActionSheet(
                                        title: Text('Choose From'.tr),
                                        actions: <CupertinoActionSheetAction>[
                                          CupertinoActionSheetAction(
                                            isDefaultAction: true,
                                            onPressed: () {
                                              Navigator.pop(context);
                                              value.selectFromGalleryOthers(
                                                  'camera', index);
                                            },
                                            child: Text('Camera'.tr),
                                          ),
                                          CupertinoActionSheetAction(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              value.selectFromGalleryOthers(
                                                  'gallery', index);
                                            },
                                            child: Text('Gallery'.tr),
                                          ),
                                          CupertinoActionSheetAction(
                                            isDestructiveAction: true,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel'.tr),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: FadeInImage(
                                        image: NetworkImage(
                                            '${Environments.apiBaseURL}storage/images/${value.gallery[index]}'),
                                        placeholder: const AssetImage(
                                            "assets/images/placeholder.jpeg"),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/images/notfound.png',
                                            fit: BoxFit.cover,
                                            height: 150,
                                            width: 150,
                                          );
                                        },
                                        fit: BoxFit.cover,
                                        height: 150,
                                        width: 150,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ThemeProvider.whiteColor,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: ThemeProvider.greyColor,
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SwitchListTile(
                                  title: Text('in Gram'.tr),
                                  value: value.inGrams,
                                  activeColor: ThemeProvider.greenColor,
                                  onChanged: (bool status) {
                                    value.updateinGrams(status);
                                  },
                                ),
                                value.inGrams == true
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: value.gramTextEditor,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  ThemeProvider.whiteColor,
                                              hintText: 'Gram Value'.tr,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 8.0,
                                                      top: 14.0,
                                                      left: 10),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        ThemeProvider.appColor),
                                              ),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ThemeProvider
                                                              .greyColor)),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ThemeProvider.whiteColor,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: ThemeProvider.greyColor,
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SwitchListTile(
                                  title: Text('in KG'.tr),
                                  value: value.inKG,
                                  activeColor: ThemeProvider.greenColor,
                                  onChanged: (bool status) {
                                    setState(() {
                                      value.updateinKG(status);
                                    });
                                  },
                                ),
                                value.inKG == true
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: value.kgTextEditor,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  ThemeProvider.whiteColor,
                                              hintText: 'KG Value'.tr,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 8.0,
                                                      top: 14.0,
                                                      left: 10),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        ThemeProvider.appColor),
                                              ),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ThemeProvider
                                                              .greyColor)),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ThemeProvider.whiteColor,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: ThemeProvider.greyColor,
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SwitchListTile(
                                  title: Text('in Liter'.tr),
                                  value: value.inLiter,
                                  activeColor: ThemeProvider.greenColor,
                                  onChanged: (bool status) {
                                    value.updateinLiter(status);
                                  },
                                ),
                                value.inLiter == true
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: value.literTextEditor,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  ThemeProvider.whiteColor,
                                              hintText: 'Liter Value'.tr,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 8.0,
                                                      top: 14.0,
                                                      left: 10),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        ThemeProvider.appColor),
                                              ),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ThemeProvider
                                                              .greyColor)),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ThemeProvider.whiteColor,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: ThemeProvider.greyColor,
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SwitchListTile(
                                  title: Text('in PCs'.tr),
                                  value: value.inPCs,
                                  activeColor: ThemeProvider.greenColor,
                                  onChanged: (bool status) {
                                    value.updateinPCs(status);
                                  },
                                ),
                                value.inPCs == true
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: value.pcsTextEditor,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  ThemeProvider.whiteColor,
                                              hintText: 'PCs Value'.tr,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 8.0,
                                                      top: 14.0,
                                                      left: 10),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        ThemeProvider.appColor),
                                              ),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ThemeProvider
                                                              .greyColor)),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ThemeProvider.whiteColor,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: ThemeProvider.greyColor,
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SwitchListTile(
                                  title: Text('in ML'.tr),
                                  value: value.inML,
                                  activeColor: ThemeProvider.greenColor,
                                  onChanged: (bool status) {
                                    value.updateinML(status);
                                  },
                                ),
                                value.inML == true
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextField(
                                            controller: value.mlTextEditor,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  ThemeProvider.whiteColor,
                                              hintText: 'ML Value'.tr,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 8.0,
                                                      top: 14.0,
                                                      left: 10),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        ThemeProvider.appColor),
                                              ),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ThemeProvider
                                                              .greyColor)),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                            onTap: () async {
                              value.openTimePicker();
                            },
                            child: Container(
                              height: 55,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: ThemeProvider.whiteColor,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: ThemeProvider.greyColor,
                                    blurRadius: 5.0,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Expired Date'.tr,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${value.expDate.day}/${value.expDate.month}/${value.expDate.year}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: value.type == 'create'
                  ? InkWell(
                      onTap: () {
                        value.saveProducts();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                        decoration: contentButtonStyle(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SUBMIT'.tr,
                              style: const TextStyle(
                                  color: ThemeProvider.whiteColor,
                                  fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        value.updateProduct();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                        decoration: const BoxDecoration(
                          color: ThemeProvider.greenColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'UPDATE'.tr,
                              style: const TextStyle(
                                  color: ThemeProvider.whiteColor,
                                  fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    )),
        );
      },
    );
  }
}

contentButtonStyle() {
  return const BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.circular(100.0),
    ),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromARGB(229, 52, 1, 255),
        Color.fromARGB(228, 111, 75, 255),
      ],
    ),
  );
}

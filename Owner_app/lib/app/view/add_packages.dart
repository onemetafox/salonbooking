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
import 'package:ultimate_salon_owner_flutter/app/controller/add_packages_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class AddPackagesScreen extends StatefulWidget {
  const AddPackagesScreen({Key? key}) : super(key: key);

  @override
  State<AddPackagesScreen> createState() => _AddPackagesScreenState();
}

class _AddPackagesScreenState extends State<AddPackagesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPackagesController>(
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
                'Add Packages'.tr,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: ThemeProvider.titleStyle,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                            value.onSelectPackages();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                value.savedCategories.isEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                            Text(
                                              'Select Categories'.tr,
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                          ])
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: List.generate(
                                          value.savedCategories.length,
                                          (name) => Column(
                                            children: [
                                              Text(
                                                value.savedCategories[name]
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                const Icon(
                                  Icons.chevron_right,
                                  color: ThemeProvider.greyColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    value.userType == true
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid),
                              ),
                              child: InkWell(
                                onTap: () {
                                  value.onSelectSpecialist();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      value.savedSpecialist.isEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                  Text(
                                                    'Select Specialist'.tr,
                                                    style: const TextStyle(
                                                        fontSize: 17),
                                                  ),
                                                ])
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: List.generate(
                                                value.savedSpecialist.length,
                                                (firstName) => Row(
                                                  children: [
                                                    Text(
                                                      value.savedSpecialist[
                                                              firstName]
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 17),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      const Icon(
                                        Icons.chevron_right,
                                        color: ThemeProvider.greyColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: value.packagesNameTextEditor,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeProvider.whiteColor,
                            hintText: 'Packages Name'.tr,
                            contentPadding: const EdgeInsets.only(
                                bottom: 8.0, top: 14.0, left: 10),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ThemeProvider.appColor),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ThemeProvider.greyColor)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: value.priceTextEditor,
                          onChanged: (String txt) {
                            value.onRealPrice(txt);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeProvider.whiteColor,
                            hintText: 'Price'.tr,
                            contentPadding: const EdgeInsets.only(
                                bottom: 8.0, top: 14.0, left: 10),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ThemeProvider.appColor),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ThemeProvider.greyColor)),
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
                            hintText: 'Discount'.tr,
                            contentPadding: const EdgeInsets.only(
                                bottom: 8.0, top: 14.0, left: 10),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ThemeProvider.appColor),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ThemeProvider.greyColor)),
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
                            fillColor: ThemeProvider.whiteColor,
                            hintText: 'Sell Price'.tr,
                            contentPadding: const EdgeInsets.only(
                                bottom: 8.0, top: 14.0, left: 10),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ThemeProvider.appColor),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ThemeProvider.greyColor)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: value.descriptionTextEditor,
                          maxLines: 5,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeProvider.whiteColor,
                            hintText: 'Descriptions'.tr,
                            contentPadding: const EdgeInsets.only(
                                bottom: 8.0, top: 14.0, left: 10),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ThemeProvider.appColor),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ThemeProvider.greyColor)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: value.durationTextEditor,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeProvider.whiteColor,
                            hintText: 'Duration'.tr,
                            contentPadding: const EdgeInsets.only(
                                bottom: 8.0, top: 14.0, left: 10),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ThemeProvider.appColor),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ThemeProvider.greyColor)),
                          ),
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
                  ],
                ),
              ),
            ),
            bottomNavigationBar: value.action == 'new'
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        value.onSave();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                        decoration: contentButtonStyle(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ADD PACKAGES'.tr,
                              style: const TextStyle(
                                  color: ThemeProvider.whiteColor,
                                  fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        value.onUpdate();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100.0),
                          ),
                          color: ThemeProvider.greenColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'UPDATE PACKAGES'.tr,
                              style: const TextStyle(
                                  color: ThemeProvider.whiteColor,
                                  fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
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

class FruitsList {
  String name;
  int index;
  FruitsList({required this.name, required this.index});
}

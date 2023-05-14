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
import 'package:ultimate_salon_owner_flutter/app/controller/individual_profile_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class IndividualProfileScreen extends StatefulWidget {
  const IndividualProfileScreen({Key? key}) : super(key: key);

  @override
  State<IndividualProfileScreen> createState() =>
      _IndividualProfileScreenState();
}

class _IndividualProfileScreenState extends State<IndividualProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndividualProfileController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          body: value.apiCalled == false
              ? const Center(
                  child:
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: 300,
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: FadeInImage(
                              image: NetworkImage(
                                  '${Environments.apiBaseURL}storage/images/${value.backgroundCover}'),
                              placeholder: const AssetImage(
                                  "assets/images/placeholder.jpeg"),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/notfound.png',
                                  fit: BoxFit.cover,
                                  height: 300,
                                  width: double.infinity,
                                );
                              },
                              fit: BoxFit.cover,
                              height: 300,
                              width: double.infinity,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 70, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: ThemeProvider.whiteColor,
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: ThemeProvider.greenColor,
                                    child: IconButton(
                                      onPressed: () {
                                        showCupertinoModalPopup<void>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CupertinoActionSheet(
                                            title: Text('Choose From'.tr),
                                            actions: <
                                                CupertinoActionSheetAction>[
                                              CupertinoActionSheetAction(
                                                isDefaultAction: true,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  value.selectFromGallery(
                                                      'camera');
                                                },
                                                child: Text('Camera'.tr),
                                              ),
                                              CupertinoActionSheetAction(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  value.selectFromGallery(
                                                      'gallery');
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
                                      icon: const Icon(
                                        Icons.edit,
                                        color: ThemeProvider.whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: ThemeProvider.appColor,
                                      style: BorderStyle.solid),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    value.onSelectCategories();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 11),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: List.generate(
                                            value.individualInfo.webCatesData!
                                                .length,
                                            (index) => Column(
                                              children: [
                                                Text(
                                                  value.individualInfo
                                                      .webCatesData![index].name
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
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: value.aboutTextEditor,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeProvider.whiteColor,
                                    hintText: 'Brief Of Salon'.tr,
                                    hintStyle: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 12),
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 8.0, top: 14.0, left: 20),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: ThemeProvider.appColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: ThemeProvider.appColor)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: value.addressTextEditor,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeProvider.whiteColor,
                                    hintText: 'Enter Address..'.tr,
                                    hintStyle: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 12),
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 8.0, top: 14.0, left: 20),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: ThemeProvider.appColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: ThemeProvider.appColor)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  border: Border.all(
                                      color: ThemeProvider.appColor,
                                      style: BorderStyle.solid),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    value.onSelectCities();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 11),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          value.individualInfo.cityData!.name
                                                          .toString() ==
                                                      '' ||
                                                  value.individualInfo.cityData!
                                                      .name!.isEmpty
                                              ? 'Select'.tr
                                              : value
                                                  .individualInfo.cityData!.name
                                                  .toString(),
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                        const Icon(
                                          Icons.expand_more,
                                          color: ThemeProvider.greyColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: value.zipCodeTextEditor,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeProvider.whiteColor,
                                    hintText: 'ZIP Code'.tr,
                                    hintStyle: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 12),
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 8.0, top: 14.0, left: 20),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: ThemeProvider.appColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: const BorderSide(
                                            color: ThemeProvider.appColor)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: value.latTextEditor,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeProvider.whiteColor,
                                    hintText: 'Latitude'.tr,
                                    hintStyle: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 12),
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 8.0, top: 14.0, left: 20),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: ThemeProvider.appColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: const BorderSide(
                                            color: ThemeProvider.appColor)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: value.lngTextEditor,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeProvider.whiteColor,
                                    hintText: 'Longitude'.tr,
                                    hintStyle: const TextStyle(
                                        color: ThemeProvider.greyColor,
                                        fontSize: 12),
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 8.0, top: 14.0, left: 20),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: const BorderSide(
                                          color: ThemeProvider.appColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: const BorderSide(
                                            color: ThemeProvider.appColor)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Have Popular ?'.tr,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Switch(
                                    value: value.havePopular,
                                    onChanged: (bool status) {
                                      value.updatePopular(status);
                                    },
                                    activeColor: ThemeProvider.greenColor,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Have Shop ?'.tr,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Switch(
                                    value: value.haveShop,
                                    onChanged: (bool status) {
                                      value.updateShop(status);
                                    },
                                    activeColor: ThemeProvider.greenColor,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Have Home ?'.tr,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Switch(
                                    value: value.haveHome,
                                    onChanged: (bool status) {
                                      value.updateHome(status);
                                    },
                                    activeColor: ThemeProvider.greenColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Opening Hour'.tr,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'bold',
                                        color: ThemeProvider.blackColor),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onAddNewTiming();
                                    },
                                    child: const Icon(
                                      Icons.add_circle,
                                      color: ThemeProvider.appColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: List.generate(
                                value.timesList.length,
                                (index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.circle,
                                          color: ThemeProvider.greenColor,
                                          size: 15),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                value.getDayName(value
                                                    .timesList[index]
                                                    .day as int),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color:
                                                        ThemeProvider.appColor,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Text(
                                              '${value.timesList[index].openTime} - ${value.timesList[index].closeTime}',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.blackColor,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: 23.0,
                                              width: 70,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        ThemeProvider
                                                            .orangeColor),
                                                onPressed: () {
                                                  value.onEditTime(
                                                      value.getDayName(value
                                                          .timesList[index]
                                                          .day as int),
                                                      value.timesList[index]
                                                          .openTime
                                                          .toString(),
                                                      value.timesList[index]
                                                          .closeTime
                                                          .toString());
                                                },
                                                child: Text(
                                                  'Edit'.tr,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontFamily: 'bold'),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: InkWell(
              onTap: () {
                value.updateIndividual();
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
                          color: ThemeProvider.whiteColor, fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
          ),
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

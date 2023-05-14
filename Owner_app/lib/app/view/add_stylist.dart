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
import 'package:ultimate_salon_owner_flutter/app/controller/add_stylist_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class AddStylistScreen extends StatefulWidget {
  const AddStylistScreen({Key? key}) : super(key: key);

  @override
  State<AddStylistScreen> createState() => _AddStylistScreenState();
}

class _AddStylistScreenState extends State<AddStylistScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddStylistController>(
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
              'Add Stylist'.tr,
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
                    padding: const EdgeInsets.only(top: 30, bottom: 10),
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
                            borderRadius: BorderRadius.circular(5),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(60),
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
                                    height: 60,
                                    width: 60,
                                  );
                                },
                                fit: BoxFit.cover,
                                height: 60,
                                width: 60,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: value.firstNameTextEditor,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: ThemeProvider.whiteColor,
                          hintText: 'First Name'.tr,
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
                        controller: value.lastNameTextEditor,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: ThemeProvider.whiteColor,
                          hintText: 'Last Name'.tr,
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: Colors.grey, style: BorderStyle.solid),
                      ),
                      child: InkWell(
                        onTap: () {
                          value.onSelectStylist();
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
                                              style:
                                                  const TextStyle(fontSize: 17),
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
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: value.action == 'new'
                ? InkWell(
                    onTap: () {
                      value.saveSpecilaist();
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
                  )
                : InkWell(
                    onTap: () {
                      value.onUpdateSpecialist();
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
                            'UPDATE'.tr,
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

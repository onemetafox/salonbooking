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
import 'package:ultimate_salon_owner_flutter/app/controller/gallary_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class GallaryScreen extends StatefulWidget {
  const GallaryScreen({Key? key}) : super(key: key);

  @override
  State<GallaryScreen> createState() => _GallaryScreenState();
}

class _GallaryScreenState extends State<GallaryScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GallaryController>(
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
              'Gallary'.tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
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
                                return value.gallery[index] == ''
                                    ? GestureDetector(
                                        onTap: () {
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
                                                    value
                                                        .selectFromGalleryOthers(
                                                            'camera');
                                                  },
                                                  child: Text('Camera'.tr),
                                                ),
                                                CupertinoActionSheetAction(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    value
                                                        .selectFromGalleryOthers(
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
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ThemeProvider.greyColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.add),
                                              const SizedBox(height: 10),
                                              Text('Upload Image'.tr)
                                            ],
                                          ),
                                        ),
                                      )
                                    : Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.topRight,
                                        children: [
                                          SizedBox(
                                            height: 150,
                                            width: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              child: FadeInImage(
                                                image: NetworkImage(
                                                    '${Environments.apiBaseURL}storage/images/${value.gallery[index].toString()}'),
                                                placeholder: const AssetImage(
                                                    "assets/images/placeholder.jpeg"),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
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
                                          InkWell(
                                            onTap: () {
                                              value.deletePhoto(
                                                  value.gallery[index]);
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: ThemeProvider.redColor,
                                            ),
                                          ),
                                        ],
                                      );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                      'Update Images'.tr,
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

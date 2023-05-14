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
import 'package:country_code_picker/country_code_picker.dart';
import 'package:salon_user/app/controller/edit_profile_controller.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/env.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.whiteColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Edit Profile'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
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
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: 100,
                        height: 100,
                        child: FadeInImage(
                          image: NetworkImage(
                              '${Environments.apiBaseURL}storage/images/${value.cover.toString()}'),
                          placeholder: const AssetImage(
                              "assets/images/placeholder.jpeg"),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/notfound.png',
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: ThemeProvider.backgroundColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: ThemeProvider.blackColor
                                          .withOpacity(0.2),
                                      offset: const Offset(0, 1),
                                      blurRadius: 3),
                                ],
                              ),
                              child: TextFormField(
                                controller: value.firstNameTextEditor,
                                onChanged: (String txt) {},
                                cursorColor: ThemeProvider.appColor,
                                decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                        fontSize: 14,
                                        color: ThemeProvider.greyColor),
                                    border: InputBorder.none,
                                    labelText: "First Name".tr),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: ThemeProvider.backgroundColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: ThemeProvider.blackColor
                                          .withOpacity(0.2),
                                      offset: const Offset(0, 1),
                                      blurRadius: 3),
                                ],
                              ),
                              child: TextFormField(
                                controller: value.lastNameTextEditor,
                                onChanged: (String txt) {},
                                cursorColor: ThemeProvider.appColor,
                                decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                        fontSize: 14,
                                        color: ThemeProvider.greyColor),
                                    border: InputBorder.none,
                                    labelText: "Last Name".tr),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
                            title: Text('Gender'.tr),
                            actions: <CupertinoActionSheetAction>[
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                  value.updateGender(1);
                                },
                                child: Text('Male'.tr),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                  value.updateGender(0);
                                },
                                child: Text('Female'.tr),
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
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: ThemeProvider.backgroundColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    ThemeProvider.blackColor.withOpacity(0.2),
                                offset: const Offset(0, 1),
                                blurRadius: 3),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender'.tr,
                              style: const TextStyle(
                                  fontSize: 12, color: ThemeProvider.greyColor),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  value.selectedGender == 0
                                      ? 'Female'.tr
                                      : 'Male'.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: ThemeProvider.blackColor),
                                ),
                                const Icon(Icons.keyboard_arrow_down,
                                    color: ThemeProvider.greyColor)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: ThemeProvider.backgroundColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    ThemeProvider.blackColor.withOpacity(0.2),
                                offset: const Offset(0, 1),
                                blurRadius: 3),
                          ],
                        ),
                        child: TextFormField(
                          readOnly: true,
                          controller: value.emailTextEditor,
                          onChanged: (String txt) {},
                          cursorColor: ThemeProvider.appColor,
                          decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  fontSize: 14, color: ThemeProvider.greyColor),
                              border: InputBorder.none,
                              labelText: "Email".tr),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: ThemeProvider.backgroundColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      ThemeProvider.blackColor.withOpacity(0.2),
                                  offset: const Offset(0, 1),
                                  blurRadius: 3),
                            ],
                          ),
                          width: 60,
                          child: GestureDetector(
                            onTap: () {
                              CountryCodePicker(
                                onChanged: (e) => value
                                    .saveCountryCode(e.dialCode.toString()),
                                initialSelection: 'IN',
                                favorite: const ['+91', 'IN'],
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Code'.tr,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: ThemeProvider.greyColor),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  value.countryCodeMobile.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: ThemeProvider.blackColor),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: ThemeProvider.backgroundColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: ThemeProvider.blackColor
                                          .withOpacity(0.2),
                                      offset: const Offset(0, 1),
                                      blurRadius: 3),
                                ],
                              ),
                              child: TextFormField(
                                // readOnly: true,
                                controller: value.mobileTextEditor,
                                onChanged: (String txt) {},
                                cursorColor: ThemeProvider.appColor,
                                decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                        fontSize: 14,
                                        color: ThemeProvider.greyColor),
                                    border: InputBorder.none,
                                    labelText: "Phone".tr),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            value.onUpdateInfo();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeProvider.appColor,
                              shadowColor: ThemeProvider.blackColor,
                              foregroundColor: ThemeProvider.whiteColor,
                              elevation: 3,
                              shape: (RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              )),
                              padding: const EdgeInsets.all(0)),
                          child: Text(
                            'Submit'.tr,
                            style: const TextStyle(
                                letterSpacing: 1,
                                fontSize: 16,
                                color: ThemeProvider.whiteColor,
                                fontFamily: 'bold'),
                          )),
                    )
                  ],
                )),
      );
    });
  }
}

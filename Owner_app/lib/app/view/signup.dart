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
import 'package:ultimate_salon_owner_flutter/app/backend/models/city_model.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/signup_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:country_picker/country_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DateTime date = DateTime(2022, 12, 24);
  String genderValue = 'Male';
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
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
              'Send Register Request'.tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: ThemeProvider.titleStyle,
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: value.currentView == 1
                ? InkWell(
                    onTap: () {
                      value.onNext();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: contentButtonStyle(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Next'.tr,
                            style: const TextStyle(
                                color: ThemeProvider.whiteColor, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  )
                : value.currentView == 2
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  value.onBack();
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: ThemeProvider.whiteColor,
                                    backgroundColor: ThemeProvider.greyColor,
                                    shadowColor: ThemeProvider.blackColor,
                                    elevation: 3,
                                    shape: (RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                                    padding: const EdgeInsets.all(0)),
                                child: Text(
                                  'Previews'.tr,
                                  style: const TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 16,
                                      color: ThemeProvider.whiteColor,
                                      fontFamily: 'bold'),
                                )),
                          )),
                          const SizedBox(width: 10),
                          Expanded(
                              child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  value.onRegister();
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: ThemeProvider.whiteColor,
                                    backgroundColor: ThemeProvider.appColor,
                                    shadowColor: ThemeProvider.blackColor,
                                    elevation: 3,
                                    shape: (RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
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
                          )),
                        ],
                      )
                    : const SizedBox(),
          ),
          body: SingleChildScrollView(
              child: value.currentView == 1
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Select your type'.tr,
                            style: const TextStyle(
                                fontFamily: 'bold', fontSize: 14),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              value.updateType(1);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(
                                        color: ThemeProvider.greyColor)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                              value.type == 1
                                                  ? Icons.check_circle
                                                  : Icons.circle_outlined,
                                              color: value.type == 1
                                                  ? ThemeProvider.appColor
                                                  : ThemeProvider.greyColor),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Salon'.tr,
                                            style: const TextStyle(
                                                fontFamily: 'bold',
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: 56,
                                        width: 56,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/salon.png'),
                                              fit: BoxFit.cover),
                                        ),
                                        child: const SizedBox(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              value.updateType(0);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(
                                        color: ThemeProvider.greyColor)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                              value.type == 0
                                                  ? Icons.check_circle
                                                  : Icons.circle_outlined,
                                              color: value.type == 0
                                                  ? ThemeProvider.appColor
                                                  : ThemeProvider.greyColor),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Individual'.tr,
                                            style: const TextStyle(
                                                fontFamily: 'bold',
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: 56,
                                        width: 56,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/freelancer.png'),
                                              fit: BoxFit.cover),
                                        ),
                                        child: const SizedBox(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: myBoxDecoration(),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showCupertinoModalPopup<
                                                        void>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          CupertinoActionSheet(
                                                        title: Text(
                                                            'Choose From'.tr),
                                                        actions: <
                                                            CupertinoActionSheetAction>[
                                                          CupertinoActionSheetAction(
                                                            child: Text(
                                                                'Gallery'.tr),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              value.selectFromGallery(
                                                                  'gallery');
                                                            },
                                                          ),
                                                          CupertinoActionSheetAction(
                                                            child: Text(
                                                                'Camera'.tr),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              value
                                                                  .selectFromGallery(
                                                                      'camera');
                                                            },
                                                          ),
                                                          CupertinoActionSheetAction(
                                                            child: Text(
                                                              'Cancel'.tr,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'bold',
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: FadeInImage(
                                                    height: 100,
                                                    width: 100,
                                                    image: NetworkImage(
                                                        '${Environments.apiBaseURL}storage/images/${value.cover}'),
                                                    placeholder: const AssetImage(
                                                        "assets/images/placeholder.jpeg"),
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        'assets/images/notfound.png',
                                                        fit: BoxFit.cover,
                                                        height: 100,
                                                        width: 100,
                                                      );
                                                    },
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: textFieldDecoration(),
                                        child: TextFormField(
                                          controller: value.emailTextEditor,
                                          readOnly: value.emailVerified,
                                          onChanged: (String txt) {},
                                          cursorColor: ThemeProvider.appColor,
                                          decoration: InputDecoration(
                                            labelStyle: const TextStyle(
                                                fontSize: 14,
                                                color: ThemeProvider.greyColor),
                                            border: InputBorder.none,
                                            labelText: "Email".tr,
                                            suffix: GestureDetector(
                                                onTap: () {
                                                  value.verifyEmail();
                                                },
                                                child: Text(
                                                  value.emailVerified == false
                                                      ? 'Verify'.tr
                                                      : 'Verified'.tr,
                                                  style: TextStyle(
                                                      color:
                                                          value.emailVerified ==
                                                                  true
                                                              ? ThemeProvider
                                                                  .appColor
                                                              : ThemeProvider
                                                                  .redColor,
                                                      fontSize: 12),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 10),
                                          decoration: textFieldDecoration(),
                                          width: 60,
                                          child: GestureDetector(
                                            onTap: () {
                                              showCountryPicker(
                                                context: context,
                                                favorite: <String>['IN'],
                                                showPhoneCode: true,
                                                onSelect: (Country country) {
                                                  if (value.phoneVerified ==
                                                      false) {
                                                    value.saveCountryCode(
                                                        country.phoneCode
                                                            .toString());
                                                    debugPrint(
                                                        country.phoneCode);
                                                  }
                                                },
                                                countryListTheme:
                                                    CountryListThemeData(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    topRight:
                                                        Radius.circular(40.0),
                                                  ),
                                                  inputDecoration:
                                                      InputDecoration(
                                                    labelText: 'Search'.tr,
                                                    hintText:
                                                        'Start typing to search'
                                                            .tr,
                                                    prefixIcon: const Icon(
                                                        Icons.search),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: const Color(
                                                                0xFF8C98A8)
                                                            .withOpacity(0.2),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                smallText('Code'.tr),
                                                const SizedBox(height: 4),
                                                bodyText1(value
                                                    .countryCodeMobile
                                                    .toString()),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              decoration: textFieldDecoration(),
                                              child: TextFormField(
                                                controller:
                                                    value.mobileTextEditor,
                                                onChanged: (String txt) {},
                                                readOnly: value.phoneVerified,
                                                cursorColor:
                                                    ThemeProvider.appColor,
                                                decoration: InputDecoration(
                                                  labelStyle: const TextStyle(
                                                      fontSize: 14,
                                                      color: ThemeProvider
                                                          .greyColor),
                                                  border: InputBorder.none,
                                                  labelText: "Phone".tr,
                                                  suffix: GestureDetector(
                                                      onTap: () {
                                                        value.verifyPhone();
                                                      },
                                                      child: Text(
                                                        value.phoneVerified ==
                                                                false
                                                            ? 'Verify'.tr
                                                            : 'Verified'.tr,
                                                        style: TextStyle(
                                                            color: value.phoneVerified ==
                                                                    true
                                                                ? ThemeProvider
                                                                    .appColor
                                                                : ThemeProvider
                                                                    .redColor,
                                                            fontSize: 12),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    value.type == 1
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              decoration: textFieldDecoration(),
                                              child: TextFormField(
                                                controller: value.name,
                                                onChanged: (String txt) {},
                                                cursorColor:
                                                    ThemeProvider.appColor,
                                                decoration: InputDecoration(
                                                  labelStyle: const TextStyle(
                                                      fontSize: 14,
                                                      color: ThemeProvider
                                                          .greyColor),
                                                  border: InputBorder.none,
                                                  labelText: "Salon Name".tr,
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              decoration: textFieldDecoration(),
                                              child: TextFormField(
                                                controller:
                                                    value.firstNameTextEditor,
                                                onChanged: (String txt) {},
                                                cursorColor:
                                                    ThemeProvider.appColor,
                                                decoration: InputDecoration(
                                                    labelStyle: const TextStyle(
                                                        fontSize: 14,
                                                        color: ThemeProvider
                                                            .greyColor),
                                                    border: InputBorder.none,
                                                    labelText: "First Name".tr),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              decoration: textFieldDecoration(),
                                              child: TextFormField(
                                                controller:
                                                    value.lastNameTextEditor,
                                                onChanged: (String txt) {},
                                                cursorColor:
                                                    ThemeProvider.appColor,
                                                decoration: InputDecoration(
                                                    labelStyle: const TextStyle(
                                                        fontSize: 14,
                                                        color: ThemeProvider
                                                            .greyColor),
                                                    border: InputBorder.none,
                                                    labelText: "Last Name".tr),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: textFieldDecoration(),
                                        child: TextFormField(
                                          controller: value.passwordTextEditor,
                                          onChanged: (String txt) {},
                                          cursorColor: ThemeProvider.appColor,
                                          obscureText: value.passwordVisible,
                                          decoration: InputDecoration(
                                            labelStyle: const TextStyle(
                                                fontSize: 14,
                                                color: ThemeProvider.greyColor),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                value.togglePasswordBtn();
                                              },
                                              icon: Icon(
                                                value.passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: ThemeProvider.appColor,
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            labelText: "Password".tr,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: textFieldDecoration(),
                                        child: TextFormField(
                                          controller:
                                              value.confirmPasswordTextEditor,
                                          onChanged: (String txt) {},
                                          cursorColor: ThemeProvider.appColor,
                                          obscureText: value.passwordVisible,
                                          decoration: InputDecoration(
                                            labelStyle: const TextStyle(
                                                fontSize: 14,
                                                color: ThemeProvider.greyColor),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                value.togglePasswordBtn();
                                              },
                                              icon: Icon(
                                                value.passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: ThemeProvider.appColor,
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            labelText: "Confirm Password".tr,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: textFieldDecoration(),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: DropdownButton<String>(
                                            value: value.selectedGender,
                                            isExpanded: true,
                                            underline: const SizedBox(),
                                            onChanged: (String? newValue) {
                                              value.saveGender(
                                                  newValue.toString());
                                            },
                                            items: value.genderList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: textFieldDecoration(),
                                        child: TextFormField(
                                          controller: value.feeStart,
                                          cursorColor: ThemeProvider.appColor,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelStyle: const TextStyle(
                                                fontSize: 14,
                                                color: ThemeProvider.greyColor),
                                            border: InputBorder.none,
                                            labelText: "Fee Started Price".tr,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: textFieldDecoration(),
                                        child: TextFormField(
                                          controller:
                                              value.descriptionsTextEditor,
                                          onChanged: (String txt) {},
                                          cursorColor: ThemeProvider.appColor,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 4,
                                          decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ThemeProvider.greyColor),
                                              border: InputBorder.none,
                                              labelText: "Description".tr),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        value.onCategoriesList();
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        decoration: textFieldDecoration(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            smallText('Select Category'.tr),
                                            const SizedBox(height: 4),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                  value.servedCategoriesList
                                                      .length,
                                                  (index) => Text(value
                                                      .servedCategoriesList[
                                                          index]
                                                      .name
                                                      .toString())),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: textFieldDecoration(),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: DropdownButton<CityModal>(
                                            underline: const SizedBox(),
                                            isExpanded: true,
                                            value: value.selectedCity,
                                            items: value.cityList
                                                .map((CityModal value) {
                                              return DropdownMenuItem<
                                                  CityModal>(
                                                value: value,
                                                child:
                                                    Text(value.name.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              value.onCityChanged(
                                                  newValue as CityModal);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: textFieldDecoration(),
                                        child: TextFormField(
                                          controller: value.addressTextEditor,
                                          onChanged: (String txt) {},
                                          cursorColor: ThemeProvider.appColor,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 4,
                                          decoration: InputDecoration(
                                              labelStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ThemeProvider.greyColor),
                                              border: InputBorder.none,
                                              labelText: "Address".tr),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: textFieldDecoration(),
                                        child: TextFormField(
                                          controller: value.zipcode,
                                          cursorColor: ThemeProvider.appColor,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            labelStyle: const TextStyle(
                                                fontSize: 14,
                                                color: ThemeProvider.greyColor),
                                            border: InputBorder.none,
                                            labelText: "Zipcode".tr,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Select Latitude & Longitude from here :'
                                              .tr,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'regular'),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            value.openLink();
                                          },
                                          child: const Text(
                                              'https://www.mapcoordinates.net/en',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'regular',
                                                  color: Colors.blue)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Please enter valid Latitude & Longitude otherwise app may not work properly.'
                                              .tr,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'regular'),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: textFieldDecoration(),
                                        child: TextFormField(
                                          controller: value.lat,
                                          cursorColor: ThemeProvider.appColor,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelStyle: const TextStyle(
                                                fontSize: 14,
                                                color: ThemeProvider.greyColor),
                                            border: InputBorder.none,
                                            labelText: "Your Latitude".tr,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: textFieldDecoration(),
                                        child: TextFormField(
                                          controller: value.lng,
                                          keyboardType: TextInputType.number,
                                          cursorColor: ThemeProvider.appColor,
                                          decoration: InputDecoration(
                                            labelStyle: const TextStyle(
                                                fontSize: 14,
                                                color: ThemeProvider.greyColor),
                                            border: InputBorder.none,
                                            labelText: "Your Longitude".tr,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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

textFieldDecoration() {
  return BoxDecoration(
    color: ThemeProvider.backgroundColor,
    borderRadius: const BorderRadius.all(
      Radius.circular(8.0),
    ),
    boxShadow: [
      BoxShadow(
          color: ThemeProvider.blackColor.withOpacity(0.2),
          offset: const Offset(0, 1),
          blurRadius: 3),
    ],
  );
}

myBoxDecoration() {
  return BoxDecoration(
    color: ThemeProvider.whiteColor,
    borderRadius: const BorderRadius.all(
      Radius.circular(8),
    ),
    boxShadow: [
      BoxShadow(
          color: ThemeProvider.blackColor.withOpacity(0.2),
          offset: const Offset(0, 1),
          blurRadius: 3),
    ],
  );
}

smallText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 11, color: ThemeProvider.greyColor),
  );
}

bodyText1(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 14, color: ThemeProvider.blackColor),
  );
}

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
import 'package:ultimate_salon_owner_flutter/app/controller/verify_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyController>(builder: (value) {
      return AbsorbPointer(
        absorbing: value.isLogin.value == false ? false : true,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/p7.jpg'),
                )),
              ),
            ),
            Scaffold(
              backgroundColor: ThemeProvider.transparent,
              appBar: AppBar(
                backgroundColor: ThemeProvider.transparent,
                elevation: 0,
                iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
                titleSpacing: 0,
              ),
              bottomNavigationBar: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: 450,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(
                    color: ThemeProvider.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: value.divNumber == 1
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  Text(
                                    'Forgot Password ?'.tr,
                                    style: const TextStyle(
                                        color: ThemeProvider.blackColor,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: value.emailReset,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeProvider.whiteColor,
                                    hintText: 'Email ID'.tr,
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: value.isLogin.value == false
                                  ? InkWell(
                                      onTap: () {
                                        value.sendMail();
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13.0),
                                        decoration: contentButtonStyle(),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Send OTP'.tr,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.whiteColor,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 13.0),
                                      decoration: contentButtonStyle(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          CircularProgressIndicator(
                                            color: ThemeProvider.whiteColor,
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  Text(
                                    'Gereate Password'.tr,
                                    style: const TextStyle(
                                        color: ThemeProvider.blackColor,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: value.passwordReset,
                                  textInputAction: TextInputAction.done,
                                  obscureText:
                                      value.passwordVisible.value == true
                                          ? false
                                          : true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeProvider.whiteColor,
                                    labelText: 'New Password'.tr,
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
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        value.togglePassword();
                                      },
                                      child: Icon(
                                        value.passwordVisible.value == false
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: ThemeProvider.appColor,
                                      ),
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
                                  controller: value.confirmPasswordReset,
                                  textInputAction: TextInputAction.done,
                                  obscureText:
                                      value.passwordVisible.value == true
                                          ? false
                                          : true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeProvider.whiteColor,
                                    labelText: 'Confirm Password'.tr,
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
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        value.togglePassword();
                                      },
                                      child: Icon(
                                        value.passwordVisible.value == false
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: ThemeProvider.appColor,
                                      ),
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: value.isLogin.value == false
                                  ? InkWell(
                                      onTap: () {
                                        value.updatePassword();
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13.0),
                                        decoration: contentButtonStyle(),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Update Password'.tr,
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.whiteColor,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 13.0),
                                      decoration: contentButtonStyle(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          CircularProgressIndicator(
                                            color: ThemeProvider.whiteColor,
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      );
    });
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

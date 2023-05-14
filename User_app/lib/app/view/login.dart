/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_user/app/controller/login_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (value) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: ThemeProvider.appColor,
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage('assets/images/login.jpg'),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -20,
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                child: value.loginVersion == 0
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: TextField(
                                    controller: value.emailTextEditor,
                                    decoration: InputDecoration(
                                      labelText: 'Email Address'.tr,
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 8.0, top: 14.0),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: TextField(
                                    controller: value.passwordTextEditor,
                                    obscureText: value.passwordVisible == true
                                        ? false
                                        : true,
                                    decoration: InputDecoration(
                                      labelText: 'Password'.tr,
                                      filled: true,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            value.passwordVisible =
                                                !value.passwordVisible;
                                          });
                                        },
                                        icon: Icon(
                                          value.passwordVisible == false
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: ThemeProvider.appColor,
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 8.0, top: 14.0),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(
                                      AppRouter.getResetPasswordRoute());
                                },
                                child: Text(
                                  'Forgot Password ?'.tr,
                                  style: const TextStyle(
                                      color: ThemeProvider.appColor),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 20.0),
                            child: InkWell(
                              onTap: () {
                                value.onLogin();
                              },
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 13.0),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                    color: ThemeProvider.appColor),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Log In'.tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: 'bold'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have account ?".tr,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            AppRouter.getRegisterRoute());
                                      },
                                      child: Text(
                                        'Sign Up'.tr,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'bold',
                                            color: ThemeProvider.appColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : value.loginVersion == 1
                        ? Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: CountryCodePicker(
                                          onChanged: (e) =>
                                              value.updateCountryCode(
                                                  e.dialCode.toString()),
                                          initialSelection: 'IN',
                                          favorite: const ['+91', 'IN'],
                                          showCountryOnly: false,
                                          showOnlyCountryWhenClosed: false,
                                          alignLeft: false,
                                        )),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: TextFormField(
                                          controller: value.mobileNo,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'Mobile Number'.tr,
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blueAccent),
                                            ),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextField(
                                        controller: value.passwordTextEditor,
                                        obscureText:
                                            value.passwordVisible == true
                                                ? false
                                                : true,
                                        decoration: InputDecoration(
                                          labelText: 'Password'.tr,
                                          filled: true,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                value.passwordVisible =
                                                    !value.passwordVisible;
                                              });
                                            },
                                            icon: Icon(
                                              value.passwordVisible == false
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: ThemeProvider.appColor,
                                            ),
                                          ),
                                          fillColor: Colors.white,
                                          contentPadding: const EdgeInsets.only(
                                              bottom: 8.0, top: 14.0),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent),
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRouter.getResetPasswordRoute());
                                    },
                                    child: Text(
                                      'Forgot Password ?'.tr,
                                      style: const TextStyle(
                                          color: ThemeProvider.appColor),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0.0, vertical: 20.0),
                                child: InkWell(
                                  onTap: () {
                                    value.loginWithPhonePassword();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13.0),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                        color: ThemeProvider.appColor),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Log In'.tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: 'bold'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Don't have account ?".tr,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                AppRouter.getRegisterRoute());
                                          },
                                          child: Text(
                                            'Sign Up'.tr,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'bold',
                                                color: ThemeProvider.appColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: CountryCodePicker(
                                          onChanged: (e) =>
                                              value.updateCountryCode(
                                                  e.dialCode.toString()),
                                          initialSelection: 'IN',
                                          favorite: const ['+91', 'IN'],
                                          showCountryOnly: false,
                                          showOnlyCountryWhenClosed: false,
                                          alignLeft: false,
                                        )),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: TextFormField(
                                          controller: value.mobileNo,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'Mobile Number'.tr,
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blueAccent),
                                            ),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRouter.getResetPasswordRoute());
                                    },
                                    child: Text(
                                      'Forgot Password ?'.tr,
                                      style: const TextStyle(
                                          color: ThemeProvider.appColor),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0.0, vertical: 20.0),
                                child: InkWell(
                                  onTap: () {
                                    value.loginWithPhoneOTP();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13.0),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                        color: ThemeProvider.appColor),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Log In'.tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: 'bold'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Don't have account ?".tr,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                AppRouter.getRegisterRoute());
                                          },
                                          child: Text(
                                            'Sign Up'.tr,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'bold',
                                                color: ThemeProvider.appColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

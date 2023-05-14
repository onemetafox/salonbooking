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
import 'package:salon_user/app/controller/account_controller.dart';
import 'package:salon_user/app/controller/reset_password_controller.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/env.dart';

class SideMenuScreen extends StatefulWidget {
  const SideMenuScreen({Key? key}) : super(key: key);

  @override
  State<SideMenuScreen> createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (value) {
      return Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            value.parser.haveLoggedIn()
                ? SizedBox(
                    height: 160,
                    child: DrawerHeader(
                      decoration: const BoxDecoration(
                        color: ThemeProvider.appColor,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: FadeInImage(
                              height: 80,
                              width: 80,
                              image: NetworkImage(
                                  '${Environments.apiBaseURL}storage/images/${value.cover}'),
                              placeholder: const AssetImage(
                                  "assets/images/placeholder.jpeg"),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/notfound.png',
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80,
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            '${value.firstName} ${value.lastName}',
                            style: const TextStyle(
                                fontFamily: 'bold',
                                fontSize: 14,
                                color: ThemeProvider.whiteColor),
                          ),
                          Text(
                            value.email,
                            style: const TextStyle(
                                color: ThemeProvider.whiteColor,
                                fontSize: 10,
                                fontFamily: 'regular'),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 50,
                  ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: ThemeProvider.backgroundColor))),
              child: ListView(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.all(0),
                children: [
                  value.parser.haveLoggedIn() == false
                      ? ListTile(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                            value.onLogin();
                          },
                          contentPadding: const EdgeInsets.all(0),
                          leading: const Icon(Icons.receipt_outlined,
                              color: ThemeProvider.greyColor),
                          title: Text('Sign In / Sign Up'.tr,
                              style: sidemenuTitle()),
                        )
                      : const SizedBox(),
                  value.parser.haveLoggedIn()
                      ? ListTile(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                            Get.toNamed(AppRouter.appointmentDetailRoutes);
                          },
                          contentPadding: const EdgeInsets.all(0),
                          leading: const Icon(Icons.receipt_outlined,
                              color: ThemeProvider.greyColor),
                          title: Text('Appointment'.tr, style: sidemenuTitle()),
                        )
                      : const SizedBox(),
                  value.parser.haveLoggedIn()
                      ? ListTile(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                            Get.toNamed(AppRouter.addressRoutes);
                          },
                          contentPadding: const EdgeInsets.all(0),
                          leading: const Icon(Icons.location_on_outlined,
                              color: ThemeProvider.greyColor),
                          title: Text('Address'.tr, style: sidemenuTitle()),
                        )
                      : const SizedBox(),
                  value.parser.haveLoggedIn()
                      ? ListTile(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                            Get.toNamed(AppRouter.walletRoutes);
                          },
                          contentPadding: const EdgeInsets.all(0),
                          leading: const Icon(
                              Icons.account_balance_wallet_outlined,
                              color: ThemeProvider.greyColor),
                          title: Text('Wallet'.tr, style: sidemenuTitle()),
                        )
                      : const SizedBox(),
                  value.parser.haveLoggedIn()
                      ? ListTile(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                            Get.toNamed(AppRouter.referAndEarnRoutes);
                          },
                          contentPadding: const EdgeInsets.all(0),
                          leading: const Icon(Icons.savings_outlined,
                              color: ThemeProvider.greyColor),
                          title:
                              Text('Refer & Earn'.tr, style: sidemenuTitle()),
                        )
                      : const SizedBox(),
                  ListTile(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                      Get.delete<ResetPasswordController>(force: true);
                      Get.toNamed(AppRouter.getResetPasswordRoute());
                    },
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Icon(Icons.code_rounded,
                        color: ThemeProvider.greyColor),
                    title: Text('Change Password'.tr, style: sidemenuTitle()),
                  ),
                  ListTile(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                      Get.toNamed(AppRouter.languagesRoutes);
                    },
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Icon(Icons.language_outlined,
                        color: ThemeProvider.greyColor),
                    title: Text('Languages'.tr, style: sidemenuTitle()),
                  ),
                  value.parser.haveLoggedIn()
                      ? ListTile(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                            Get.toNamed(AppRouter.accountChatRoutes);
                          },
                          contentPadding: const EdgeInsets.all(0),
                          leading: const Icon(Icons.message_outlined,
                              color: ThemeProvider.greyColor),
                          title: Text('Chats'.tr, style: sidemenuTitle()),
                        )
                      : const SizedBox(),
                  ListTile(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                      Get.toNamed(AppRouter.contactUsRoutes);
                    },
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Icon(Icons.contact_page_outlined,
                        color: ThemeProvider.greyColor),
                    title: Text('Contact Us'.tr, style: sidemenuTitle()),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                children: [
                  ListTile(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                      value.onAppPages('Frequently Asked Questions'.tr, '5');
                    },
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Icon(Icons.flag_outlined,
                        color: ThemeProvider.greyColor),
                    title: Text('Frequently Asked Questions'.tr,
                        style: sidemenuTitle()),
                  ),
                  ListTile(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                      value.onAppPages('Help'.tr, '6');
                    },
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Icon(Icons.help_outline,
                        color: ThemeProvider.greyColor),
                    title: Text('Help'.tr, style: sidemenuTitle()),
                  ),
                  ListTile(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                      value.onAppPages('Privacy Policy'.tr, '2');
                    },
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Icon(Icons.security_outlined,
                        color: ThemeProvider.greyColor),
                    title: Text('Privacy Policy'.tr, style: sidemenuTitle()),
                  ),
                  ListTile(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                      value.onAppPages('Terms & Conditions'.tr, '3');
                    },
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Icon(Icons.privacy_tip_outlined,
                        color: ThemeProvider.greyColor),
                    title:
                        Text('Terms & Conditions'.tr, style: sidemenuTitle()),
                  ),
                  ListTile(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                      value.onAppPages('About us'.tr, '1');
                    },
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Icon(Icons.info_outline,
                        color: ThemeProvider.greyColor),
                    title: Text('About'.tr, style: sidemenuTitle()),
                  ),
                  value.parser.haveLoggedIn()
                      ? ListTile(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                            Get.toNamed(AppRouter.login);
                          },
                          contentPadding: const EdgeInsets.all(0),
                          leading: const Icon(Icons.logout,
                              color: ThemeProvider.greyColor),
                          title: Text('Logout'.tr, style: sidemenuTitle()),
                        )
                      : const SizedBox(),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  // Widget _buildProfile() {
  //   return ;
  // }

  sidemenuTitle() {
    return const TextStyle(fontFamily: 'bold');
  }
}

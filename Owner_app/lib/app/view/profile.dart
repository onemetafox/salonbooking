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
import 'package:ultimate_salon_owner_flutter/app/controller/profile_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: ThemeProvider.backgroundColor,
                floating: true,
                pinned: true,
                toolbarHeight: 308,
                snap: false,
                elevation: 0,
                forceElevated: true,
                iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                title: Column(
                  children: [
                    Container(
                      height: 200,
                      margin: const EdgeInsets.only(bottom: 50),
                      // decoration: ,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: value.parser.getBackground() == 'NA'
                                ? const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/h4.jpg'),
                                        fit: BoxFit.cover),
                                  )
                                : const BoxDecoration(),
                            child: value.parser.getBackground() == 'NA'
                                ? const SizedBox()
                                : FadeInImage(
                                    image: NetworkImage(
                                        '${Environments.apiBaseURL}storage/images/${value.parser.getBackground().toString()}'),
                                    placeholder: const AssetImage(
                                        "assets/images/placeholder.jpeg"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/notfound.png',
                                        fit: BoxFit.cover,
                                        height: 40,
                                        width: 40,
                                      );
                                    },
                                    fit: BoxFit.cover,
                                    height: 40,
                                    width: 40,
                                  ),
                          ),
                          Positioned(
                            bottom: -40,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: ThemeProvider.whiteColor,
                                border: Border.all(
                                    color: ThemeProvider.appColor, width: 3),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(40),
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        '${Environments.apiBaseURL}storage/images/${value.parser.getCover().toString()}'),
                                    placeholder: const AssetImage(
                                        "assets/images/placeholder.jpeg"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/notfound.png',
                                        fit: BoxFit.cover,
                                        height: 40,
                                        width: 40,
                                      );
                                    },
                                    fit: BoxFit.cover,
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      value.parser.getName(),
                      style: const TextStyle(
                          fontFamily: 'bold', color: ThemeProvider.blackColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '(${value.parser.getTotalRating()}${' Reviews) '.tr}',
                              style: const TextStyle(
                                  fontSize: 12, color: ThemeProvider.greyColor),
                            ),
                            WidgetSpan(
                              child: Icon(Icons.star,
                                  size: 15,
                                  color: value.parser.getRating() >= 1
                                      ? ThemeProvider.orangeColor
                                      : ThemeProvider.greyColor),
                            ),
                            WidgetSpan(
                              child: Icon(Icons.star,
                                  size: 15,
                                  color: value.parser.getRating() >= 2
                                      ? ThemeProvider.orangeColor
                                      : ThemeProvider.greyColor),
                            ),
                            WidgetSpan(
                              child: Icon(Icons.star,
                                  size: 15,
                                  color: value.parser.getRating() >= 3
                                      ? ThemeProvider.orangeColor
                                      : ThemeProvider.greyColor),
                            ),
                            WidgetSpan(
                              child: Icon(Icons.star,
                                  size: 15,
                                  color: value.parser.getRating() >= 4
                                      ? ThemeProvider.orangeColor
                                      : ThemeProvider.greyColor),
                            ),
                            WidgetSpan(
                              child: Icon(Icons.star,
                                  size: 15,
                                  color: value.parser.getRating() >= 5
                                      ? ThemeProvider.orangeColor
                                      : ThemeProvider.greyColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: AppBar(
                    titleSpacing: 0,
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    backgroundColor: ThemeProvider.backgroundColor,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Your Profile'.tr,
                        style: const TextStyle(
                            fontFamily: 'bold',
                            fontSize: 14,
                            color: ThemeProvider.blackColor),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ThemeProvider.whiteColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: ThemeProvider.greyColor,
                                    blurRadius: 5.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      value.onEditProfile();
                                    },
                                    child: _buildList(
                                        Icons.edit_outlined, 'Edit Profile'.tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onGallary();
                                    },
                                    child: _buildList(
                                        Icons.image_outlined, 'Gallary'.tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onInbox();
                                    },
                                    child: _buildList(
                                        Icons.chat_outlined, 'Chats'.tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onReview();
                                    },
                                    child: _buildList(
                                        Icons.rate_review_outlined,
                                        'Review'.tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onSlot();
                                    },
                                    child: _buildList(
                                        Icons.access_time, 'Slots'.tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onServices();
                                    },
                                    child: _buildList(
                                        Icons.access_time, 'Services'.tr),
                                  ),
                                  value.type == true
                                      ? InkWell(
                                          onTap: () {
                                            value.onStylist();
                                          },
                                          child: _buildList(
                                              Icons.style_outlined,
                                              'Stylist'.tr),
                                        )
                                      : const SizedBox(),
                                  InkWell(
                                    onTap: () {
                                      value.onProducts();
                                    },
                                    child: _buildList(
                                        Icons.list_alt, 'Products'.tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onPackages();
                                    },
                                    child: _buildList(
                                        Icons.receipt_long_outlined,
                                        'Packages'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onHistory();
                                    },
                                    child:
                                        _buildList(Icons.history, 'History'.tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onLanguages();
                                    },
                                    child: _buildList(
                                        Icons.language, 'Languages'.tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onContactUs();
                                    },
                                    child: _buildList(
                                        Icons.contact_page_outlined,
                                        'Contact Us'.tr),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ThemeProvider.whiteColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: ThemeProvider.greyColor,
                                    blurRadius: 5.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      value.onAppPages(
                                          'Frequently Asked Questions'.tr, '5');
                                    },
                                    child: _buildList(Icons.flag_outlined,
                                        'Frequently Asked Questions'.tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onAppPages('Help'.tr, '6');
                                    },
                                    child: _buildList(
                                        Icons.help_outline, 'Help'.tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onAppPages(
                                          'Privacy Policy'.tr, '2');
                                    },
                                    child: _buildList(Icons.security_outlined,
                                        'Privacy Policy'.tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onAppPages(
                                          'Terms & Conditions'.tr, '3');
                                    },
                                    child: _buildList(
                                        Icons.privacy_tip_outlined,
                                        'Terms & Conditions'.tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onAppPages('About us'.tr, '1');
                                    },
                                    child: _buildList(
                                        Icons.info_outline, 'About'.tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.onLogout();
                                    },
                                    child:
                                        _buildList(Icons.logout, 'Logout'.tr),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildList(icn, txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ThemeProvider.appColor,
            child: Icon(
              icn,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '$txt',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

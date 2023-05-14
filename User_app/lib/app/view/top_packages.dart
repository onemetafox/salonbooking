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
import 'package:salon_user/app/controller/top_packages_controller.dart';
import 'package:salon_user/app/util/theme.dart';

class TopPackagesScreen extends StatefulWidget {
  const TopPackagesScreen({Key? key}) : super(key: key);

  @override
  State<TopPackagesScreen> createState() => _TopPackagesScreenState();
}

class _TopPackagesScreenState extends State<TopPackagesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopPackagesController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: ThemeProvider.appColor,
                floating: true,
                pinned: true,
                snap: false,
                elevation: 0,
                forceElevated: true,
                iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
                titleSpacing: 0,
                centerTitle: true,
                title: Text(
                  'Top Packages & Offers'.tr,
                  style: ThemeProvider.titleStyle,
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
                            for (var item in [
                              1,
                              2,
                              3,
                              4,
                              5,
                              6,
                              7,
                              8,
                              9,
                              10,
                              11,
                              12,
                              13
                            ])
                              _buildNewContent(value, item),
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

  Widget _buildNewContent(value, item) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ThemeProvider.whiteColor,
        boxShadow: const [
          BoxShadow(
              color: ThemeProvider.greyColor,
              blurRadius: 5.0,
              offset: Offset(0.7, 2.0)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(40),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset('assets/images/p1.jpg'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ms.Jolly Jonthon'.tr,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: 'bold', fontSize: 14),
                    ),
                    Text(
                      'Aromatherapy'.tr,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 3),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: ' \$ 130 '.tr,
                            style: const TextStyle(
                                fontSize: 12,
                                color: ThemeProvider.blackColor,
                                decoration: TextDecoration.lineThrough),
                          ),
                          TextSpan(
                            text: ' 20% OFF '.tr,
                            style: const TextStyle(
                                fontSize: 12,
                                color: ThemeProvider.greenColor,
                                fontFamily: 'bold'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    RichText(
                      text: TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.star,
                              size: 15,
                              color: ThemeProvider.orangeColor,
                            ),
                          ),
                          const WidgetSpan(
                            child: Icon(
                              Icons.star,
                              size: 15,
                              color: ThemeProvider.orangeColor,
                            ),
                          ),
                          const WidgetSpan(
                            child: Icon(
                              Icons.star,
                              size: 15,
                              color: ThemeProvider.orangeColor,
                            ),
                          ),
                          const WidgetSpan(
                            child: Icon(
                              Icons.star,
                              size: 15,
                              color: ThemeProvider.orangeColor,
                            ),
                          ),
                          const WidgetSpan(
                            child: Icon(
                              Icons.star,
                              size: 15,
                              color: ThemeProvider.orangeColor,
                            ),
                          ),
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.comment,
                                size: 15,
                                color: ThemeProvider.blackColor,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: ' 11'.tr,
                            style: const TextStyle(
                                fontSize: 10, color: ThemeProvider.blackColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Fee start from '.tr,
                        style: const TextStyle(
                          fontSize: 12,
                          color: ThemeProvider.greyColor,
                        ),
                      ),
                      TextSpan(
                        text: ' \$ 100 '.tr,
                        style: const TextStyle(
                            fontSize: 15,
                            color: ThemeProvider.appColor,
                            fontFamily: 'bold'),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: ThemeProvider.appColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () {
                    value.onBookAppointment();
                  },
                  child: Center(
                    child: Text(
                      'Continue'.tr,
                      style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'bold',
                          color: ThemeProvider.whiteColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

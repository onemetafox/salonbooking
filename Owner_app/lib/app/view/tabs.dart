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
import 'package:ultimate_salon_owner_flutter/app/controller/tabs_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/view/analytics.dart';
import 'package:ultimate_salon_owner_flutter/app/view/appointment.dart';
import 'package:ultimate_salon_owner_flutter/app/view/calendar.dart';
import 'package:ultimate_salon_owner_flutter/app/view/history.dart';
import 'package:ultimate_salon_owner_flutter/app/view/profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      AppointmentScreen(),
      HistoryScreen(),
      AnalyticScreen(),
      CalendarScreen(),
      ProfileScreen()
    ];
    return GetBuilder<TabsController>(builder: (value) {
      return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: InkWell(
                child: (GNav(
                  rippleColor: ThemeProvider.appColor,
                  hoverColor: ThemeProvider.appColor,
                  haptic: false,
                  curve: Curves.easeOutExpo,
                  tabBorderRadius: 15,
                  textStyle:
                      const TextStyle(fontFamily: 'bold', color: Colors.white),
                  duration: const Duration(milliseconds: 300),
                  gap: 5,
                  color: Colors.grey.shade400,
                  activeColor: Colors.white,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  tabs: [
                    GButton(
                      icon: Icons.content_paste_outlined,
                      text: 'Appoinment'.tr,
                      backgroundColor: ThemeProvider.appColor,
                    ),
                    GButton(
                      icon: Icons.history_outlined,
                      text: 'Orders'.tr,
                      backgroundColor: ThemeProvider.appColor,
                    ),
                    GButton(
                      icon: Icons.currency_exchange_outlined,
                      text: 'Earnings'.tr,
                      backgroundColor: ThemeProvider.appColor,
                    ),
                    GButton(
                      icon: Icons.calendar_today_outlined,
                      text: 'Calendar'.tr,
                      backgroundColor: ThemeProvider.appColor,
                    ),
                    GButton(
                      icon: Icons.person_outlined,
                      text: 'Profile'.tr,
                      backgroundColor: ThemeProvider.appColor,
                    ),
                  ],
                  selectedIndex: value.tabId,
                  onTabChange: (index) {
                    value.updateTabId(index);
                  },
                )),
              ),
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: value.tabController,
            children: pages,
          ),
        ),
      );
    });
  }
}

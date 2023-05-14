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
import 'package:salon_user/app/controller/refer_and_earn_controller.dart';
import 'package:salon_user/app/util/theme.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({Key? key}) : super(key: key);

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReferAndEarnController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Refer & Earn'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: value.apiCalled == false
                ? const Center(
                    child: CircularProgressIndicator(
                        color: ThemeProvider.appColor),
                  )
                : Container(
                    decoration: BoxDecoration(
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
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value.referralData.title.toString(),
                          style: const TextStyle(
                              color: ThemeProvider.appColor,
                              fontFamily: 'bold',
                              fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          value.referralData.message.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black45, fontSize: 14),
                        ),
                        const SizedBox(height: 14),
                        Image.asset('assets/images/gift.png',
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.fitHeight),
                        const SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: ThemeProvider.greyColor.shade400),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: value.myCode.toString(),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    value.copyToClipBoard();
                                  },
                                  icon: const Icon(Icons.copy))
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () {
                                  value.share();
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
                                  'Invite Now'.tr,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'medium',
                                      fontSize: 16),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

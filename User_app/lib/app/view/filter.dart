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
import 'package:salon_user/app/util/theme.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

enum Gender { male, female, other }

class _FilterScreenState extends State<FilterScreen> {
  Gender? _character = Gender.male;
  late RangeValues _currentRangeValues = const RangeValues(40, 80);
  int tabID = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeProvider.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ThemeProvider.appColor,
            floating: true,
            toolbarHeight: 70,
            pinned: true,
            snap: false,
            elevation: 0,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            automaticallyImplyLeading: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'Cancle'.tr,
                        style: const TextStyle(
                            fontSize: 15, color: ThemeProvider.whiteColor),
                      ),
                    ),
                    Text(
                      'Filters'.tr,
                      style: const TextStyle(
                          fontSize: 15, color: ThemeProvider.whiteColor),
                    ),
                    Text(
                      'Done'.tr,
                      style: const TextStyle(
                          fontSize: 15, color: ThemeProvider.whiteColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle('Services'.tr),
                      Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        alignment: WrapAlignment.start,
                        children: <Widget>[
                          _buildChip('Hairstyle'.tr, ThemeProvider.whiteColor),
                          _buildChip('Mackup'.tr, ThemeProvider.whiteColor),
                          _buildChip(
                              'Hair Styling'.tr, ThemeProvider.whiteColor),
                          _buildChip('Spa'.tr, ThemeProvider.appColor),
                          _buildChip(
                              'Facial Mackup'.tr, ThemeProvider.whiteColor),
                          _buildChip(
                              'Trim & Saving'.tr, ThemeProvider.whiteColor),
                        ],
                      ),
                      _buildTitle('Rating'.tr),
                      Row(
                        children: const [
                          Icon(
                            Icons.star,
                            color: ThemeProvider.appColor,
                            size: 30,
                          ),
                          Icon(
                            Icons.star,
                            color: ThemeProvider.appColor,
                            size: 30,
                          ),
                          Icon(
                            Icons.star,
                            color: ThemeProvider.appColor,
                            size: 30,
                          ),
                          Icon(
                            Icons.star,
                            color: ThemeProvider.appColor,
                            size: 30,
                          ),
                          Icon(
                            Icons.star,
                            color: ThemeProvider.greyColor,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            '4.0 Star',
                            style: TextStyle(
                                color: ThemeProvider.greyColor,
                                fontFamily: 'bold'),
                          ),
                        ],
                      ),
                      _buildTitle('Gender'.tr),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Male'.tr,
                                textAlign: TextAlign.start,
                              ),
                              leading: Radio<Gender>(
                                value: Gender.male,
                                activeColor: ThemeProvider.appColor,
                                groupValue: _character,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Female'.tr,
                                textAlign: TextAlign.start,
                              ),
                              leading: Radio<Gender>(
                                value: Gender.female,
                                activeColor: ThemeProvider.appColor,
                                groupValue: _character,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Other'.tr,
                                textAlign: TextAlign.start,
                              ),
                              leading: Radio<Gender>(
                                value: Gender.other,
                                activeColor: ThemeProvider.appColor,
                                groupValue: _character,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      _buildTitle('Distance'.tr),
                      RangeSlider(
                        values: _currentRangeValues,
                        max: 100,
                        divisions: 5,
                        activeColor: ThemeProvider.appColor,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                          });
                        },
                      ),
                      _buildTitle('Sort by'.tr),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Most Popular'.tr,
                            overflow: TextOverflow.ellipsis,
                            style:
                                const TextStyle(color: ThemeProvider.appColor),
                          ),
                          const Icon(
                            Icons.check,
                            color: ThemeProvider.appColor,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cost Low To High'.tr,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: ThemeProvider.blackColor),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cost High To Low'.tr,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: ThemeProvider.blackColor),
                          ),
                        ],
                      ),
                      _buildTitle('Price'.tr),
                      _buildSegment(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$txt',
            style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(txt, clr) {
    return ActionChip(
      elevation: 0.0,
      padding: const EdgeInsets.all(2.0),
      label: Text(
        txt,
        style: const TextStyle(color: ThemeProvider.blackColor),
      ),
      onPressed: () {
        //
      },
      backgroundColor: clr,
      shape: const StadiumBorder(
          side: BorderSide(
        color: ThemeProvider.greyColor,
      )),
    );
  }

  Widget _buildSegment() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                tabID = 1;
              });
            },
            child: Container(
              height: 30,
              decoration: segmentDecoration(1),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('\$', style: segmentText(1)),
              )),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                tabID = 2;
              });
            },
            child: Container(
              height: 30,
              decoration: segmentDecoration(2),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('\$\$', style: segmentText(2)),
              )),
            ),
          ),
          InkWell(
              onTap: () {
                setState(() {
                  tabID = 3;
                });
              },
              child: Container(
                height: 30,
                decoration: segmentDecoration(3),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text('\$\$\$', style: segmentText(3)),
                )),
              )),
        ],
      ),
    );
  }

  segmentDecoration(val) {
    return BoxDecoration(
      color:
          tabID == val ? ThemeProvider.appColor : ThemeProvider.backgroundColor,
      borderRadius: BorderRadius.circular(100),
    );
  }

  segmentText(val) {
    return TextStyle(
        color:
            tabID == val ? ThemeProvider.whiteColor : ThemeProvider.greyColor);
  }
}

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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salon_user/app/controller/find_location_controller.dart';
import 'package:salon_user/app/util/theme.dart';

class FindLocationScreen extends StatefulWidget {
  const FindLocationScreen({Key? key}) : super(key: key);

  @override
  State<FindLocationScreen> createState() => _FindLocationScreenState();
}

class _FindLocationScreenState extends State<FindLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FindLocationController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'Find Location'.tr,
            style: ThemeProvider.titleStyle,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.cancel_outlined,
                color: ThemeProvider.whiteColor,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: ThemeProvider.greyColor.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: ThemeProvider.greyColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          controller: value.searchbarText,
                          onChanged: (content) {
                            value.onSearchChanged(content);
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search location'.tr),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              value.getList.isNotEmpty
                  ? Container(
                      decoration:
                          const BoxDecoration(color: ThemeProvider.whiteColor),
                      child: Column(
                        children: [
                          for (var item in value.getList)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  value.getLatLngFromAddress(
                                      item.description.toString());
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.search),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      item.description!.length > 25
                                          ? '${item.description!.substring(0, 25)}...'
                                          : item.description!,
                                    )
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    )
                  : const SizedBox(),
              value.getList.isEmpty
                  ? TextButton(
                      onPressed: () {
                        value.getLocation();
                      },
                      child: Text(
                        'Use My Current Location'.tr.toUpperCase(),
                        style: const TextStyle(
                            color: ThemeProvider.appColor, letterSpacing: 1.1),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: value.getList.isEmpty ? 20 : 0,
              ),
              value.getList.isEmpty
                  ? SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: GoogleMap(
                        onMapCreated: value.onMapCreated,
                        markers: value.markers,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(value.myLat, value.myLng), zoom: 15),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: value.getList.isEmpty ? 20 : 0,
              ),
              value.isConfirmed == true
                  ? ElevatedButton(
                      onPressed: () {
                        value.onConfirmLocation();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: ThemeProvider.whiteColor,
                        backgroundColor: ThemeProvider.appColor,
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Confirm Location'.tr.toUpperCase(),
                        style: const TextStyle(
                            color: ThemeProvider.whiteColor,
                            fontSize: 14,
                            letterSpacing: 1.1),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      );
    });
  }
}

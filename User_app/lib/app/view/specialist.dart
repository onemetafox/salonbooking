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
import 'package:salon_user/app/controller/service_cart_controller.dart';
import 'package:salon_user/app/controller/specialist_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';

class SpecialistScreen extends StatefulWidget {
  const SpecialistScreen({Key? key}) : super(key: key);

  @override
  State<SpecialistScreen> createState() => _SpecialistScreenState();
}

class _SpecialistScreenState extends State<SpecialistScreen> {
  int tabID = 1;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          body: value.apiCalled == false
              ? const Center(
                  child:
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: ThemeProvider.backgroundColor,
                      floating: true,
                      pinned: true,
                      toolbarHeight: 400,
                      snap: false,
                      elevation: 0,
                      forceElevated: true,
                      iconTheme:
                          const IconThemeData(color: ThemeProvider.appColor),
                      automaticallyImplyLeading: false,
                      titleSpacing: 0,
                      title: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                height: 200,
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 50),
                                child: FadeInImage(
                                  image: NetworkImage(
                                      '${Environments.apiBaseURL}storage/images/${value.individualDetails.background.toString()}'),
                                  placeholder: const AssetImage(
                                      "assets/images/placeholder.jpeg"),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/notfound.png',
                                        fit: BoxFit.cover);
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            ThemeProvider.transparent,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.arrow_back,
                                            color: ThemeProvider.whiteColor,
                                          ),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ThemeProvider.appColor,
                                            width: 3),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(40),
                                          child: FadeInImage(
                                            image: NetworkImage(
                                                '${Environments.apiBaseURL}storage/images/${value.userInfo.cover.toString()}'),
                                            placeholder: const AssetImage(
                                                "assets/images/placeholder.jpeg"),
                                            imageErrorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  'assets/images/notfound.png',
                                                  fit: BoxFit.cover);
                                            },
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      right: 5,
                                      bottom: 5,
                                      child: SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              ThemeProvider.greenColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: -40,
                                left: 10,
                                child: Container(
                                  height: 25,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: ThemeProvider.greenColor),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'OPEN'.tr,
                                      style: const TextStyle(
                                          color: ThemeProvider.greenColor,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${value.userInfo.firstName} ${value.userInfo.lastName}',
                            style: const TextStyle(
                              fontFamily: 'bold',
                              color: ThemeProvider.blackColor,
                            ),
                          ),
                          Text(
                            value.userInfo.email.toString(),
                            style: const TextStyle(
                                color: ThemeProvider.greyColor, fontSize: 12),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.star,
                                      size: 15,
                                      color:
                                          value.individualDetails.rating! >= 1
                                              ? ThemeProvider.orangeColor
                                              : ThemeProvider.greyColor,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.star,
                                      size: 15,
                                      color:
                                          value.individualDetails.rating! >= 2
                                              ? ThemeProvider.orangeColor
                                              : ThemeProvider.greyColor,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.star,
                                      size: 15,
                                      color:
                                          value.individualDetails.rating! >= 3
                                              ? ThemeProvider.orangeColor
                                              : ThemeProvider.greyColor,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.star,
                                      size: 15,
                                      color:
                                          value.individualDetails.rating! >= 4
                                              ? ThemeProvider.orangeColor
                                              : ThemeProvider.greyColor,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.star,
                                      size: 15,
                                      color:
                                          value.individualDetails.rating! >= 5
                                              ? ThemeProvider.orangeColor
                                              : ThemeProvider.greyColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' ( ${value.individualDetails.totalRating} ${'Reviews)'.tr}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: ThemeProvider.greyColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        value.openWebsite();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: ThemeProvider.secondaryAppColor
                                              .withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: const Icon(
                                          Icons.language,
                                          size: 20,
                                          color: ThemeProvider.whiteColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Website'.tr,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: ThemeProvider.greyColor),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        value.callIndividual();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: ThemeProvider.greenColor
                                              .withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: const Icon(
                                          Icons.call,
                                          size: 20,
                                          color: ThemeProvider.whiteColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Call'.tr,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: ThemeProvider.greyColor),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        value.onChat();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: ThemeProvider.orangeColor
                                              .withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: const Icon(
                                          Icons.chat_outlined,
                                          size: 20,
                                          color: ThemeProvider.whiteColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Chat'.tr,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: ThemeProvider.greyColor),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        value.openMap();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: ThemeProvider.redColor
                                              .withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: const Icon(
                                          Icons.directions,
                                          size: 20,
                                          color: ThemeProvider.whiteColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Direction'.tr,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: ThemeProvider.greyColor),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        value.share();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: ThemeProvider.orangeColor
                                              .withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: const Icon(
                                          Icons.share,
                                          size: 20,
                                          color: ThemeProvider.whiteColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Share'.tr,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: ThemeProvider.greyColor),
                                    ),
                                  ],
                                ),
                              ],
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
                          title: DefaultTabController(
                            length: 3,
                            child: Column(
                              children: [
                                TabBar(
                                  controller: value.tabController,
                                  labelColor: ThemeProvider.blackColor,
                                  isScrollable: false,
                                  labelStyle:
                                      const TextStyle(fontFamily: 'regular'),
                                  unselectedLabelColor: ThemeProvider.greyColor,
                                  labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  indicator: const UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                        width: 2.0,
                                        color: ThemeProvider.appColor),
                                  ),
                                  tabs: [
                                    Tab(
                                      text: 'Basic Info'.tr,
                                    ),
                                    Tab(
                                      text: 'Portfolio'.tr,
                                    ),
                                    Tab(
                                      text: 'Review'.tr,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: TabBarView(
                              controller: value.tabController,
                              children: [
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'About'.tr,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'bold',
                                                        color: ThemeProvider
                                                            .blackColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              value.individualDetails.about
                                                  .toString(),
                                              style: const TextStyle(
                                                  color:
                                                      ThemeProvider.blackColor,
                                                  fontSize: 15),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Opening Hour'.tr,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'bold',
                                                        color: ThemeProvider
                                                            .blackColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                                children: List.generate(
                                              value.individualDetails.timing!
                                                  .length,
                                              (index) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons.circle,
                                                        color: ThemeProvider
                                                            .greenColor,
                                                        size: 15),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            value.dayList[value
                                                                .individualDetails
                                                                .timing![index]
                                                                .day as int],
                                                            style: const TextStyle(
                                                                color: ThemeProvider
                                                                    .greyColor,
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            '${value.individualDetails.timing![index].openTime}   :   ${value.individualDetails.timing![index].closeTime}',
                                                            style: const TextStyle(
                                                                color: ThemeProvider
                                                                    .blackColor,
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Address'.tr,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'bold',
                                                        color: ThemeProvider
                                                            .blackColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: Text(
                                                        value.individualDetails
                                                            .address
                                                            .toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: ThemeProvider
                                                                .greyColor),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          const WidgetSpan(
                                                            child: Icon(
                                                              Icons
                                                                  .near_me_outlined,
                                                              size: 15,
                                                              color: ThemeProvider
                                                                  .orangeColor,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                ' Get Direction - ${value.getDistance}${'KM'.tr}',
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: ThemeProvider
                                                                    .orangeColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: SizedBox.fromSize(
                                                    size: const Size.fromRadius(
                                                        35),
                                                    child: GoogleMap(
                                                        onMapCreated: value
                                                            .onMapCreated(),
                                                        markers: value.markers,
                                                        initialCameraPosition:
                                                            CameraPosition(
                                                                target: LatLng(
                                                                    value.individualDetails
                                                                            .lat
                                                                        as double,
                                                                    value.individualDetails
                                                                            .lng
                                                                        as double),
                                                                zoom: 5),
                                                        myLocationButtonEnabled:
                                                            false,
                                                        zoomControlsEnabled:
                                                            false),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Photos'.tr,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'bold',
                                                        color: ThemeProvider
                                                            .blackColor),
                                                  ),
                                                  Text(
                                                    'View All'.tr,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: ThemeProvider
                                                            .greyColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                  value.gallery.length,
                                                  (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: SizedBox.fromSize(
                                                        size: const Size
                                                            .fromRadius(35),
                                                        child: FadeInImage(
                                                          image: NetworkImage(
                                                              '${Environments.apiBaseURL}storage/images/${value.gallery[index].toString()}'),
                                                          placeholder:
                                                              const AssetImage(
                                                                  "assets/images/placeholder.jpeg"),
                                                          imageErrorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image.asset(
                                                                'assets/images/notfound.png',
                                                                fit: BoxFit
                                                                    .cover);
                                                          },
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      children: [
                                        _buildSegment(),
                                        if (tabID == 1)
                                          value.categoriesList.isNotEmpty
                                              ? Column(
                                                  children: List.generate(
                                                    value.categoriesList.length,
                                                    (index) => Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 70,
                                                            width: 70,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: ThemeProvider
                                                                  .backgroundColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                child: SizedBox
                                                                    .fromSize(
                                                                  size: const Size
                                                                      .fromRadius(20),
                                                                  child:
                                                                      FadeInImage(
                                                                    image: NetworkImage(
                                                                        '${Environments.apiBaseURL}storage/images/${value.categoriesList[index].cover.toString()}'),
                                                                    placeholder:
                                                                        const AssetImage(
                                                                            "assets/images/placeholder.jpeg"),
                                                                    imageErrorBuilder:
                                                                        (context,
                                                                            error,
                                                                            stackTrace) {
                                                                      return Image.asset(
                                                                          'assets/images/notfound.png',
                                                                          fit: BoxFit
                                                                              .cover);
                                                                    },
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          5),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        value
                                                                            .categoriesList[index]
                                                                            .name
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                ThemeProvider.blackColor,
                                                                            fontSize: 14),
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          value.onServicesView(
                                                                              value.categoriesList[index].id as int,
                                                                              value.categoriesList[index].name.toString());
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'View'
                                                                              .tr,
                                                                          style: const TextStyle(
                                                                              color: ThemeProvider.appColor,
                                                                              fontSize: 14),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      value.categoriesList[index]
                                                                              .services
                                                                              .toString() +
                                                                          '  Type'.tr,
                                                                      style: const TextStyle(
                                                                          color: ThemeProvider
                                                                              .greyColor,
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(height: 20),
                                                    SizedBox(
                                                      height: 80,
                                                      width: 80,
                                                      child: Image.asset(
                                                        "assets/images/no-data.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        'No Found'.tr,
                                                        style: const TextStyle(
                                                            fontFamily: 'bold'),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                        else if (tabID == 2)
                                          value.packagesList.isNotEmpty
                                              ? Column(
                                                  children: List.generate(
                                                      value.packagesList.length,
                                                      (index) => Column(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        5),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          150,
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        child:
                                                                            FadeInImage(
                                                                          image:
                                                                              NetworkImage('${Environments.apiBaseURL}storage/images/${value.packagesList[index].cover.toString()}'),
                                                                          placeholder:
                                                                              const AssetImage("assets/images/placeholder.jpeg"),
                                                                          imageErrorBuilder: (context,
                                                                              error,
                                                                              stackTrace) {
                                                                            return Image.asset('assets/images/notfound.png',
                                                                                fit: BoxFit.cover);
                                                                          },
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              10,
                                                                          bottom:
                                                                              3),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              value.packagesList[index].name.toString(),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: const TextStyle(color: ThemeProvider.blackColor, fontFamily: 'bold'),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              value.onPackagesDetails(value.packagesList[index].id as int, value.packagesList[index].name.toString());
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'View'.tr,
                                                                              style: const TextStyle(color: ThemeProvider.appColor, fontFamily: 'bold'),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          Get.find<SpecialistController>().currencySide == 'left'
                                                                              ? '${Get.find<SpecialistController>().currencySymbol}  ${value.packagesList[index].price}'
                                                                              : '  ${value.packagesList[index].price}${Get.find<SpecialistController>().currencySymbol}',
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                ThemeProvider.greyColor,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(height: 20),
                                                    SizedBox(
                                                      height: 80,
                                                      width: 80,
                                                      child: Image.asset(
                                                        "assets/images/no-data.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        'No Found'.tr,
                                                        style: const TextStyle(
                                                            fontFamily: 'bold'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                      ],
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${'All Reviews '.tr}(${value.ownerReviewsList.length})',
                                                style: const TextStyle(
                                                    color: ThemeProvider
                                                        .greyColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        value.ownerReviewsList.isNotEmpty
                                            ? Column(
                                                children: List.generate(
                                                value.ownerReviewsList.length,
                                                (index) => Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: ThemeProvider
                                                                .backgroundColor),
                                                        top: BorderSide(
                                                            color: ThemeProvider
                                                                .backgroundColor)),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              child: SizedBox
                                                                  .fromSize(
                                                                size: const Size
                                                                    .fromRadius(30),
                                                                child:
                                                                    FadeInImage(
                                                                  image: NetworkImage(
                                                                      '${Environments.apiBaseURL}storage/images/${value.ownerReviewsList[index].user!.cover.toString()}'),
                                                                  placeholder:
                                                                      const AssetImage(
                                                                          "assets/images/placeholder.jpeg"),
                                                                  imageErrorBuilder:
                                                                      (context,
                                                                          error,
                                                                          stackTrace) {
                                                                    return Image
                                                                        .asset(
                                                                      'assets/images/notfound.png',
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      height:
                                                                          30,
                                                                      width: 30,
                                                                    );
                                                                  },
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              120,
                                                                          child:
                                                                              Text(
                                                                            '${value.ownerReviewsList[index].user!.firstName!} ${value.ownerReviewsList[index].user!.lastName!}',
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.star,
                                                                              color: ThemeProvider.orangeColor,
                                                                              size: 15,
                                                                            ),
                                                                            SizedBox(
                                                                              child: Text(
                                                                                value.ownerReviewsList[index].rating.toString(),
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: const TextStyle(color: ThemeProvider.blackColor, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: value.ownerReviewsList[index].rating! >= 1
                                                                                ? ThemeProvider.orangeColor
                                                                                : ThemeProvider.greyColor,
                                                                            size: 15),
                                                                        Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: value.ownerReviewsList[index].rating! >= 2
                                                                                ? ThemeProvider.orangeColor
                                                                                : ThemeProvider.greyColor,
                                                                            size: 15),
                                                                        Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: value.ownerReviewsList[index].rating! >= 3
                                                                                ? ThemeProvider.orangeColor
                                                                                : ThemeProvider.greyColor,
                                                                            size: 15),
                                                                        Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: value.ownerReviewsList[index].rating! >= 4
                                                                                ? ThemeProvider.orangeColor
                                                                                : ThemeProvider.greyColor,
                                                                            size: 15),
                                                                        Icon(
                                                                            Icons
                                                                                .star,
                                                                            color: value.ownerReviewsList[index].rating! >= 5
                                                                                ? ThemeProvider.orangeColor
                                                                                : ThemeProvider.greyColor,
                                                                            size: 15),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        child: Text(
                                                          value
                                                              .ownerReviewsList[
                                                                  index]
                                                              .notes!,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ))
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(height: 20),
                                                  SizedBox(
                                                    height: 80,
                                                    width: 80,
                                                    child: Image.asset(
                                                      "assets/images/no-data.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'No Found'.tr,
                                                      style: const TextStyle(
                                                          fontFamily: 'bold'),
                                                    ),
                                                  ),
                                                ],
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
                    ),
                  ],
                ),
          bottomNavigationBar:
              Get.find<ServiceCartController>().totalItemsInCart > 0 &&
                      Get.find<ServiceCartController>().servicesFrom ==
                          'individual'
                  ? SizedBox(
                      height: 70,
                      child: InkWell(
                        onTap: () {
                          value.onCheckout();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: ThemeProvider.appColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                value.currencySide == 'left'
                                    ? '${Get.find<ServiceCartController>().totalItemsInCart} ${'Items'.tr} ${value.currencySymbol} ${Get.find<ServiceCartController>().totalPrice}'
                                    : ' ${Get.find<ServiceCartController>().totalItemsInCart} ${'Items'.tr} ${Get.find<ServiceCartController>().totalPrice}${value.currencySymbol}',
                                style: const TextStyle(
                                    color: ThemeProvider.whiteColor),
                              ),
                              Text(
                                'Book Services'.tr,
                                style: const TextStyle(
                                    color: ThemeProvider.whiteColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
        );
      },
    );
  }

  Widget _buildSegment() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ThemeProvider.appColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    tabID = 1;
                  });
                },
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: tabID == 1
                        ? ThemeProvider.appColor
                        : Colors.transparent,
                    borderRadius: tabID == 1
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )
                        : BorderRadius.circular(0),
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('Services'.tr, style: segmentText(1)),
                  )),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    tabID = 2;
                  });
                },
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: tabID == 2
                        ? ThemeProvider.appColor
                        : Colors.transparent,
                    borderRadius: tabID == 2
                        ? const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )
                        : BorderRadius.circular(0),
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('Packages'.tr, style: segmentText(2)),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  segmentText(val) {
    return TextStyle(
        fontSize: 12,
        color:
            tabID == val ? ThemeProvider.whiteColor : ThemeProvider.greyColor);
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

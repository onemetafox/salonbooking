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
import 'package:salon_user/app/controller/packages_details_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';

class PackagesDetailsScreen extends StatefulWidget {
  const PackagesDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PackagesDetailsScreen> createState() => _PackagesDetailsScreenState();
}

class _PackagesDetailsScreenState extends State<PackagesDetailsScreen> {
  final ScrollController _scrollController = ScrollController();

  bool lastStatus = true;
  var top = 0.0;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackagesDetailsController>(
      builder: (value) {
        return value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: ThemeProvider.backgroundColor,
                      pinned: true,
                      snap: false,
                      floating: true,
                      elevation: 0,
                      expandedHeight: 230.0,
                      iconTheme: const IconThemeData(color: Colors.black),
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: isShrink
                              ? ThemeProvider.blackColor
                              : ThemeProvider.whiteColor,
                        ),
                        onPressed: () {
                          value.onBack();
                        },
                      ),
                      title: Text(
                        'Packages Details'.tr,
                        style: TextStyle(
                            color: isShrink
                                ? ThemeProvider.blackColor
                                : ThemeProvider.whiteColor,
                            fontFamily: 'bold',
                            fontSize: 14),
                      ),
                      flexibleSpace: LayoutBuilder(
                        builder: (ctx, cons) {
                          top = cons.biggest.height;
                          return FlexibleSpaceBar(
                            centerTitle: true,
                            title: AnimatedOpacity(
                              opacity: top <= 80 ? 1.0 : 0.0,
                              duration: const Duration(microseconds: 200),
                            ),
                            background: SizedBox(
                              height: 180,
                              width: double.infinity,
                              child: FadeInImage(
                                image: NetworkImage(
                                    '${Environments.apiBaseURL}storage/images/${value.packagesDetails.cover}'),
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
                          );
                        },
                      ),
                    ),
                  ];
                },
                body: Scaffold(
                  backgroundColor: ThemeProvider.whiteColor,
                  bottomNavigationBar: value.packagesDetails.isBooked == false
                      ? SizedBox(
                          height: 90,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: InkWell(
                                  onTap: () {
                                    value.addPackageToCart();
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
                                          'Book Now'.tr,
                                          style: const TextStyle(
                                              color: ThemeProvider.whiteColor,
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 70,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    value.removePackageFromCart();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: ThemeProvider.redColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Remove Package'.tr,
                                        style: const TextStyle(
                                            fontFamily: 'bold',
                                            color: ThemeProvider.whiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    value.onCheckout();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: ThemeProvider.appColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Checkout'.tr,
                                        style: const TextStyle(
                                            fontFamily: 'bold',
                                            color: ThemeProvider.whiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Services Included'.tr,
                                      style: const TextStyle(
                                        fontFamily: 'bold',
                                        decoration: TextDecoration.none,
                                        color: ThemeProvider.blackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: List.generate(
                                    value.packagesDetails.services!.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            value.packagesDetails
                                                .services![index].name
                                                .toString(),
                                          ),
                                          Text(value.packagesDetails
                                              .services![index].price
                                              .toString())
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Specialist'.tr,
                                          style: const TextStyle(
                                            fontFamily: 'bold',
                                            decoration: TextDecoration.none,
                                            color: ThemeProvider.blackColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                        value
                                            .packagesDetails.specialist!.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Stack(
                                                clipBehavior: Clip.none,
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                      border: Border.all(
                                                        width: 2,
                                                        color: ThemeProvider
                                                            .appColor,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        child:
                                                            SizedBox.fromSize(
                                                          size: const Size
                                                              .fromRadius(25),
                                                          child: FadeInImage(
                                                            image: NetworkImage(
                                                                '${Environments.apiBaseURL}storage/images/${value.packagesDetails.specialist![index].cover.toString()}'),
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
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, bottom: 3),
                                                child: Text(
                                                  '${value.packagesDetails.specialist![index].firstName} ${value.packagesDetails.specialist![index].lastName}',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: ThemeProvider
                                                          .blackColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Packages Name'.tr,
                                      style: const TextStyle(
                                        fontFamily: 'bold',
                                        decoration: TextDecoration.none,
                                        color: ThemeProvider.blackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                value.packagesDetails.name.toString(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.blackColor),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Duration'.tr,
                                      style: const TextStyle(
                                        fontFamily: 'bold',
                                        decoration: TextDecoration.none,
                                        color: ThemeProvider.blackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                value.packagesDetails.duration.toString() +
                                    ' min'.tr,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: ThemeProvider.blackColor),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Price'.tr,
                                      style: const TextStyle(
                                        fontFamily: 'bold',
                                        decoration: TextDecoration.none,
                                        color: ThemeProvider.blackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: Get.find<PackagesDetailsController>()
                                                  .currencySide ==
                                              'left'
                                          ? Get.find<PackagesDetailsController>()
                                                  .currencySymbol +
                                              value.packagesDetails.price
                                                  .toString()
                                          : value.packagesDetails.price
                                                  .toString() +
                                              Get.find<
                                                      PackagesDetailsController>()
                                                  .currencySymbol,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: ThemeProvider.greyColor,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    TextSpan(
                                      text: Get.find<PackagesDetailsController>()
                                                  .currencySide ==
                                              'left'
                                          ? '${Get.find<PackagesDetailsController>().currencySymbol}  ${value.packagesDetails.off}'
                                          : '  ${value.packagesDetails.off}${Get.find<PackagesDetailsController>().currencySymbol}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: ThemeProvider.blackColor),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'About'.tr,
                                      style: const TextStyle(
                                        fontFamily: 'bold',
                                        decoration: TextDecoration.none,
                                        color: ThemeProvider.blackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                value.packagesDetails.descriptions.toString(),
                                style: const TextStyle(
                                    color: ThemeProvider.blackColor,
                                    fontSize: 15),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Photos'.tr,
                                      style: const TextStyle(
                                        fontFamily: 'bold',
                                        decoration: TextDecoration.none,
                                        color: ThemeProvider.blackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    value.gallery.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(35),
                                          child: FadeInImage(
                                            image: NetworkImage(
                                                '${Environments.apiBaseURL}storage/images/${value.gallery[index].toString()}'),
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
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

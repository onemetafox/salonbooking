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
import 'package:salon_user/app/controller/top_offers_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class TopOffersScreen extends StatefulWidget {
  const TopOffersScreen({Key? key}) : super(key: key);

  @override
  State<TopOffersScreen> createState() => _TopOffersScreenState();
}

class _TopOffersScreenState extends State<TopOffersScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopOffersController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            titleSpacing: 0,
            centerTitle: true,
            title: Text(
              'Top Salon'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                        10,
                        (index) => Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: SkeletonLine(
                                          style: SkeletonLineStyle(
                                              height: 80,
                                              width: 80,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            SkeletonParagraph(
                                              style: SkeletonParagraphStyle(
                                                lines: 1,
                                                spacing: 2,
                                                lineStyle: SkeletonLineStyle(
                                                    randomLength: true,
                                                    height: 20,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    minLength:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width),
                                              ),
                                            ),
                                            SkeletonParagraph(
                                              style: SkeletonParagraphStyle(
                                                lines: 1,
                                                spacing: 2,
                                                lineStyle: SkeletonLineStyle(
                                                  randomLength: true,
                                                  height: 10,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  minLength:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          7,
                                                ),
                                              ),
                                            ),
                                            SkeletonParagraph(
                                              style: SkeletonParagraphStyle(
                                                lines: 1,
                                                spacing: 2,
                                                lineStyle: SkeletonLineStyle(
                                                  randomLength: true,
                                                  height: 5,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  minLength:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          5,
                                                ),
                                              ),
                                            ),
                                            SkeletonParagraph(
                                              style: SkeletonParagraphStyle(
                                                lines: 1,
                                                spacing: 2,
                                                lineStyle: SkeletonLineStyle(
                                                  randomLength: true,
                                                  height: 5,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  minLength:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          3,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                  ),
                )
              : value.topSalonList.isNotEmpty
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            for (var item in value.topSalonList)
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(40),
                                            child: FadeInImage(
                                              image: NetworkImage(
                                                  '${Environments.apiBaseURL}storage/images/${item.cover.toString()}'),
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
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'bold',
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                item.address.toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons.star,
                                                            size: 15,
                                                            color: item.rating! >=
                                                                    1
                                                                ? ThemeProvider
                                                                    .orangeColor
                                                                : ThemeProvider
                                                                    .greyColor,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons.star,
                                                            size: 15,
                                                            color: item.rating! >=
                                                                    2
                                                                ? ThemeProvider
                                                                    .orangeColor
                                                                : ThemeProvider
                                                                    .greyColor,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons.star,
                                                            size: 15,
                                                            color: item.rating! >=
                                                                    3
                                                                ? ThemeProvider
                                                                    .orangeColor
                                                                : ThemeProvider
                                                                    .greyColor,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons.star,
                                                            size: 15,
                                                            color: item.rating! >=
                                                                    4
                                                                ? ThemeProvider
                                                                    .orangeColor
                                                                : ThemeProvider
                                                                    .greyColor,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons.star,
                                                            size: 15,
                                                            color: item.rating! >=
                                                                    5
                                                                ? ThemeProvider
                                                                    .orangeColor
                                                                : ThemeProvider
                                                                    .greyColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: ThemeProvider
                                                          .appColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        value.onServices(
                                                            item.uid as int);
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          'Continue'.tr,
                                                          style: const TextStyle(
                                                              fontSize: 10,
                                                              fontFamily:
                                                                  'bold',
                                                              color: ThemeProvider
                                                                  .whiteColor),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                            'No Data Found Near You!'.tr,
                            style: const TextStyle(fontFamily: 'bold'),
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }
}

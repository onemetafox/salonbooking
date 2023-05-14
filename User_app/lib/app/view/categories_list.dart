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
import 'package:salon_user/app/controller/categories_list_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class CategoriesListScreen extends StatefulWidget {
  const CategoriesListScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesListScreen> createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesListController>(
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
              value.selectedCateName,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.apiCalled == false
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 20,
                              borderRadius: BorderRadius.circular(8),
                              minLength: MediaQuery.of(context).size.width / 5,
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              7,
                              (index) => const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.circle,
                                          width: 60,
                                          height: 60),
                                    ),
                                  )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 20,
                              borderRadius: BorderRadius.circular(8),
                              minLength: MediaQuery.of(context).size.width / 5,
                            ),
                          ),
                        ),
                      ),
                      Column(
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
                                                    spacing: 6,
                                                    lineStyle:
                                                        SkeletonLineStyle(
                                                      randomLength: true,
                                                      height: 20,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      minLength:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                    ),
                                                  ),
                                                ),
                                                SkeletonParagraph(
                                                  style: SkeletonParagraphStyle(
                                                    lines: 1,
                                                    spacing: 6,
                                                    lineStyle:
                                                        SkeletonLineStyle(
                                                      randomLength: true,
                                                      height: 10,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
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
                                                    spacing: 6,
                                                    lineStyle:
                                                        SkeletonLineStyle(
                                                      randomLength: true,
                                                      height: 10,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      minLength:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              7,
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
                      )
                    ],
                  ),
                )
              : value.haveData == true
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Specialist'.tr,
                                    style: const TextStyle(
                                        fontSize: 14, fontFamily: 'bold'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (var item in value.individualCateList)
                                      GestureDetector(
                                        onTap: () {
                                          value.onSpecialist(item.uid as int);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: SizedBox.fromSize(
                                                  size:
                                                      const Size.fromRadius(30),
                                                  child: FadeInImage(
                                                    image: NetworkImage(
                                                        '${Environments.apiBaseURL}storage/images/${item.userInfo!.cover}'),
                                                    placeholder: const AssetImage(
                                                        "assets/images/placeholder.jpeg"),
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          'assets/images/notfound.png',
                                                          fit: BoxFit.cover);
                                                    },
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Text(
                                                      '${item.userInfo!.firstName} ${item.userInfo!.lastName}',
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: ThemeProvider
                                                              .greyColor,
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
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Salon'.tr,
                                    style: const TextStyle(
                                        fontSize: 14, fontFamily: 'bold'),
                                  ),
                                ],
                              ),
                            ),
                            for (var item in value.salonCateList)
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
                                child: InkWell(
                                  onTap: () {
                                    value.onServices(item.uid as int);
                                  },
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
                                                    '${Environments.apiBaseURL}storage/images/${item.cover}'),
                                                placeholder: const AssetImage(
                                                    "assets/images/placeholder.jpeg"),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(height: 2),
                                                item.categories!.length <= 2
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: List.generate(
                                                          item.categories!
                                                              .length,
                                                          (subIndex) => Text(
                                                            item
                                                                .categories![
                                                                    subIndex]
                                                                .name
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      )
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                            for (var cate
                                                                in item
                                                                    .categories!
                                                                    .take(2))
                                                              Text(cate.name
                                                                  .toString()),
                                                            const Text(
                                                                'and more')
                                                          ]),
                                                const SizedBox(height: 3),
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
                                              ],
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

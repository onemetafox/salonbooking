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
import 'package:skeletons/skeletons.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/packages_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({Key? key}) : super(key: key);

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackagesController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 50,
            title: Text(
              'Packages'.tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: ThemeProvider.titleStyle,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: ThemeProvider.blackColor,
                    backgroundColor: ThemeProvider.greenColor,
                    textStyle: const TextStyle(fontSize: 10),
                  ),
                  onPressed: () {
                    value.onAddPackages();
                  },
                  child: Text(
                    'Add New'.tr,
                    style: const TextStyle(
                        color: ThemeProvider.whiteColor, fontFamily: 'bold'),
                  ),
                ),
              ),
            ],
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        for (var item in value.packagesList)
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
                                    offset: Offset(0.7, 2.0)),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(40),
                                    child: FadeInImage(
                                      image: NetworkImage(
                                          '${Environments.apiBaseURL}storage/images/${item.cover}'),
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
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.name.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily: 'bold',
                                                fontSize: 14),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    value.updateStatus(
                                                        item.id as int,
                                                        item.status as int);
                                                  },
                                                  child: Icon(
                                                    item.status == 1
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: item.status == 1
                                                        ? ThemeProvider
                                                            .greenColor
                                                        : ThemeProvider
                                                            .blackColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                InkWell(
                                                  onTap: () {
                                                    value
                                                        .onEdit(item.id as int);
                                                  },
                                                  child: const Icon(
                                                    Icons.edit_note,
                                                    color:
                                                        ThemeProvider.appColor,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                Image.asset(
                                                                  'assets/images/delete.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 80,
                                                                  width: 80,
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Text(
                                                                  'Are you sure'
                                                                      .tr,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          24,
                                                                      fontFamily:
                                                                          'semi-bold'),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                    'to delete Slots ?'
                                                                        .tr),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          foregroundColor:
                                                                              ThemeProvider.backgroundColor,
                                                                          backgroundColor:
                                                                              ThemeProvider.redColor,
                                                                          minimumSize:
                                                                              const Size.fromHeight(35),
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          'Cancel'
                                                                              .tr,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                ThemeProvider.whiteColor,
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          value.onDestroy(item.id
                                                                              as int);
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          foregroundColor:
                                                                              ThemeProvider.backgroundColor,
                                                                          backgroundColor:
                                                                              ThemeProvider.greenColor,
                                                                          minimumSize:
                                                                              const Size.fromHeight(35),
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          'Delete'
                                                                              .tr,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                ThemeProvider.whiteColor,
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    size: 20,
                                                    color:
                                                        ThemeProvider.redColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: List.generate(
                                              item.services!.length,
                                              (subIndex) => Text(
                                                item.services![subIndex].name
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          value.userType == true
                                              ? Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0),
                                                    child: Stack(
                                                      clipBehavior: Clip.none,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      children: List.generate(
                                                          item.specialist!
                                                              .take(4)
                                                              .length,
                                                          (specialistIndex) =>
                                                              specialistIndex ==
                                                                      0
                                                                  ? Positioned(
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            25,
                                                                        width:
                                                                            25,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(100),
                                                                            border:
                                                                                Border.all(color: ThemeProvider.whiteColor),
                                                                          ),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(100),
                                                                            child:
                                                                                SizedBox.fromSize(
                                                                              size: const Size.fromRadius(40),
                                                                              child: FadeInImage(
                                                                                image: NetworkImage('${Environments.apiBaseURL}storage/images/${item.specialist![specialistIndex].cover}'),
                                                                                placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                                                                imageErrorBuilder: (context, error, stackTrace) {
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
                                                                    )
                                                                  : Positioned(
                                                                      right: 10 *
                                                                          double.parse(
                                                                              specialistIndex.toString()),
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            25,
                                                                        width:
                                                                            25,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(100),
                                                                            border:
                                                                                Border.all(color: ThemeProvider.whiteColor),
                                                                          ),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(100),
                                                                            child:
                                                                                SizedBox.fromSize(
                                                                              size: const Size.fromRadius(40),
                                                                              child: FadeInImage(
                                                                                image: NetworkImage('${Environments.apiBaseURL}storage/images/${item.specialist![specialistIndex].cover}'),
                                                                                placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                                                                imageErrorBuilder: (context, error, stackTrace) {
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
                                                                    )),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

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
import 'package:salon_user/app/controller/complaints_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComplaintsController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            'Complaints'.tr,
            style: ThemeProvider.titleStyle,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeProvider.whiteColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : AbsorbPointer(
                absorbing: value.isLogin.value == false ? false : true,
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {
                                value.onIssueModal();
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Issue With'.tr,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 8,
                                                color: ThemeProvider.greyColor),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            value.issueWithText,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color:
                                                    ThemeProvider.blackColor),
                                          ),
                                          const Icon(
                                            Icons.expand_more,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      )
                                    ]),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          value.issueWith == '1' ||
                                  value.issueWith == '2' ||
                                  value.issueWith == '6'
                              ? Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Freelancer'.tr,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 8,
                                                  color:
                                                      ThemeProvider.greyColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              value.freelancerName != ''
                                                  ? value.freelancerName
                                                  : 'Select Freelancer'.tr,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      ThemeProvider.blackColor),
                                            ),
                                            const Icon(
                                              Icons.expand_more,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        )
                                      ]),
                                )
                              : const SizedBox(),
                          value.issueWith == '4'
                              ? InkWell(
                                  onTap: () {
                                    value.onProductModal();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Select product'.tr,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 8,
                                                    color: ThemeProvider
                                                        .greyColor),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                value.productName != ''
                                                    ? value.productName
                                                    : 'Select product'.tr,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: ThemeProvider
                                                        .blackColor),
                                              ),
                                              const Icon(
                                                Icons.expand_more,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          )
                                        ]),
                                  ))
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          value.issueWith == '6'
                              ? InkWell(
                                  onTap: () {
                                    value.onServiceModal();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Select service'.tr,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 8,
                                                    color: ThemeProvider
                                                        .greyColor),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                value.serviceName != ''
                                                    ? value.serviceName
                                                    : 'Select service'.tr,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: ThemeProvider
                                                        .blackColor),
                                              ),
                                              const Icon(
                                                Icons.expand_more,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          )
                                        ]),
                                  ))
                              : const SizedBox(),
                          value.issueWith == '9'
                              ? InkWell(
                                  onTap: () {
                                    value.onPackageModal();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Select package'.tr,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 8,
                                                    color: ThemeProvider
                                                        .greyColor),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                value.serviceName != ''
                                                    ? value.serviceName
                                                    : 'Select package'.tr,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: ThemeProvider
                                                        .blackColor),
                                              ),
                                              const Icon(
                                                Icons.expand_more,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          )
                                        ]),
                                  ))
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () {
                                value.onReasonModal();
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Select Reason'.tr,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 8,
                                                color: ThemeProvider.greyColor),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            value.selectedReason != ''
                                                ? value.selectedReason
                                                : 'Select Reason'.tr,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color:
                                                    ThemeProvider.blackColor),
                                          ),
                                          const Icon(
                                            Icons.expand_more,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      )
                                    ]),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Title'.tr,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 8,
                                            color: ThemeProvider.greyColor),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: value.title,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Brief of your issue'.tr,
                                      fillColor: Colors.white,
                                    ),
                                  )
                                ]),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Comments'.tr,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 8,
                                            color: ThemeProvider.greyColor),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: value.comments,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.text,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      hintText: 'Write something on issue'.tr,
                                      fillColor: Colors.white,
                                    ),
                                  )
                                ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            childAspectRatio: 110 / 100,
                            physics: const ScrollPhysics(),
                            children: List.generate(value.savedImages.length,
                                (index) {
                              return value.savedImages[index] == '' &&
                                      index == 0
                                  ? InkWell(
                                      onTap: () {
                                        value.onImageModal();
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5.0)),
                                            border: Border.all(
                                                color:
                                                    ThemeProvider.greyColor)),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                  Icons.cloud_circle_outlined),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Upload Image'.tr,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      width: double.infinity,
                                      height: 100,
                                      child: FadeInImage(
                                        image: NetworkImage(
                                            '${Environments.apiBaseURL}storage/images/${value.savedImages[index]}'),
                                        placeholder: const AssetImage(
                                            "assets/images/placeholder.jpeg"),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/images/notfound.png',
                                            fit: BoxFit.fitWidth,
                                            height: 100,
                                            width: double.infinity,
                                          );
                                        },
                                        fit: BoxFit.fitWidth,
                                      ),
                                    );
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 20.0),
                            child: InkWell(
                              onTap: () {
                                if (value.complaintsOn == 1) {
                                  value.onSubmit();
                                } else {
                                  value.onSave();
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 13.0),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50.0),
                                    ),
                                    color: ThemeProvider.appColor),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    value.isLogin.value == true
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            'Submit'.tr,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontFamily: 'bold'),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
      );
    });
  }
}

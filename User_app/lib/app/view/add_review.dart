/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_user/app/controller/add_review_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/helper/star_rating.dart';
import 'package:salon_user/app/util/theme.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({Key? key}) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddReviewController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          title: Text(
            '${'Add Review to'.tr} ${value.name}',
            style: ThemeProvider.titleStyle,
          ),
        ),
        body: value.apiCalled == false
            ? const Center(
                child: CircularProgressIndicator(color: ThemeProvider.appColor),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
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
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          width: 100,
                          height: 100,
                          child: FadeInImage(
                            image: NetworkImage(
                                '${Environments.apiBaseURL}storage/images/${value.cover.toString()}'),
                            placeholder: const AssetImage(
                                "assets/images/placeholder.jpeg"),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/notfound.png',
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              );
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          value.name.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'medium',
                              color: ThemeProvider.blackColor),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Please rate the quality of service for the appointment you have got!'
                              .tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'medium',
                              color: ThemeProvider.blackColor),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StarRating(
                              rating: value.rate,
                              onRatingChanged: (rating) =>
                                  value.saveRating(rating),
                              color: ThemeProvider.secondaryAppColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your comments and suggesstions help us improve the service quality better!'
                              .tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'medium',
                              color: ThemeProvider.greyColor),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: const BoxDecoration(
                            color: ThemeProvider.whiteColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CupertinoTextField(
                            cursorColor: ThemeProvider.appColor,
                            controller: value.notesEditor,
                            placeholder: 'Write Notes'.tr,
                            maxLines: 4,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                value.saveReview();
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
                                'Add Review'.tr,
                                style: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 16,
                                    color: ThemeProvider.whiteColor,
                                    fontFamily: 'bold'),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }
}

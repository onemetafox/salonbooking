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
import 'package:salon_user/app/controller/account_chat_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:skeletons/skeletons.dart';

class AccountChatScreen extends StatefulWidget {
  const AccountChatScreen({Key? key}) : super(key: key);

  @override
  State<AccountChatScreen> createState() => _AccountChatScreenState();
}

class _AccountChatScreenState extends State<AccountChatScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountChatController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Inbox'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
          body: value.parser.haveLoggedIn() == false
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/search.png',
                          width: 60, height: 60),
                      const SizedBox(height: 30),
                      TextButton(
                          onPressed: () {
                            value.onLoginRoutes();
                          },
                          child: Text(
                            'Opps, Please Login or Register first!'.tr,
                            style: const TextStyle(
                                fontFamily: 'bold',
                                color: ThemeProvider.appColor),
                          )),
                    ],
                  ),
                )
              : value.apiCalled == false
                  ? SkeletonListView(
                      itemCount: 5,
                    )
                  : value.chatList.isEmpty
                      ? Center(
                          child: Column(
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
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children:
                                List.generate(value.chatList.length, (index) {
                              return value.chatList[index].senderId
                                          .toString() ==
                                      value.uid
                                  ? GestureDetector(
                                      onTap: () {
                                        value.onChat(
                                            value.chatList[index].receiverId
                                                .toString(),
                                            '${value.chatList[index].receiverName} ${value.chatList[index].receiverLastName}');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        decoration: BoxDecoration(
                                          color: ThemeProvider.whiteColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: ThemeProvider.blackColor
                                                    .withOpacity(0.2),
                                                offset: const Offset(0, 1),
                                                blurRadius: 3),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: FadeInImage(
                                                  height: 30,
                                                  width: 30,
                                                  image: NetworkImage(
                                                      '${Environments.apiBaseURL}storage/images/${value.chatList[index].receiverCover}'),
                                                  placeholder: const AssetImage(
                                                      "assets/images/placeholder.jpeg"),
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
                                                    return Image.asset(
                                                        'assets/images/notfound.png',
                                                        height: 30,
                                                        width: 30,
                                                        fit: BoxFit.fitWidth);
                                                  },
                                                  fit: BoxFit.fitWidth,
                                                )),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${value.chatList[index].receiverName} ${value.chatList[index].receiverLastName}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'medium',
                                                            color: ThemeProvider
                                                                .blackColor),
                                                      ),
                                                      Text(
                                                        value.chatList[index]
                                                            .updatedAt
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: ThemeProvider
                                                                .greyColor),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        value.onChat(
                                            value.chatList[index].senderId
                                                .toString(),
                                            '${value.chatList[index].senderFirstName} ${value.chatList[index].senderLastName}');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        decoration: BoxDecoration(
                                          color: ThemeProvider.whiteColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: ThemeProvider.blackColor
                                                    .withOpacity(0.2),
                                                offset: const Offset(0, 1),
                                                blurRadius: 3),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                height: 30,
                                                width: 30,
                                                child: FadeInImage(
                                                  height: 30,
                                                  width: 30,
                                                  image: NetworkImage(
                                                      '${Environments.apiBaseURL}storage/images/${value.chatList[index].senderCover}'),
                                                  placeholder: const AssetImage(
                                                      "assets/images/placeholder.jpeg"),
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
                                                    return Image.asset(
                                                        'assets/images/notfound.png',
                                                        height: 30,
                                                        width: 30,
                                                        fit: BoxFit.fitWidth);
                                                  },
                                                  fit: BoxFit.fitWidth,
                                                )),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${value.chatList[index].senderFirstName} ${value.chatList[index].senderLastName}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'medium',
                                                            color: ThemeProvider
                                                                .blackColor),
                                                      ),
                                                      Text(
                                                        value.chatList[index]
                                                            .updatedAt
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: ThemeProvider
                                                                .greyColor),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                            }),
                          ),
                        ),
        );
      },
    );
  }
}

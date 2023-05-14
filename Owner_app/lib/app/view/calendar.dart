/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:ultimate_salon_owner_flutter/app/controller/calendar_controller.dart';
import 'package:ultimate_salon_owner_flutter/app/util/theme.dart';
import 'package:ultimate_salon_owner_flutter/app/env.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    _calendarController.selectedDate = DateTime.now();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarsController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            toolbarHeight: 50,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            automaticallyImplyLeading: false,
            title: Text(
              'Calendar'.tr,
              style: const TextStyle(
                  fontFamily: 'bold',
                  fontSize: 14,
                  color: ThemeProvider.whiteColor),
            ),
            bottom: value.apiCalled == true
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(300),
                    child: Container(
                        child: _getAgendaViewCalendar(
                            value.events, _onViewChanged, _calendarController)),
                  )
                : null,
          ),
          body: value.apiCalled == false
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ThemeProvider.appColor,
                  ),
                )
              : value.calendarListCalled == false
                  ? SkeletonListView()
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: value.appointmentList.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                  value.appointmentList.length,
                                  (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: ThemeProvider.whiteColor,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: ThemeProvider.greyColor,
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            value.onAppointment(value
                                                .appointmentList[index]
                                                .id as int);
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: SizedBox.fromSize(
                                                        size: const Size
                                                            .fromRadius(25),
                                                        child: FadeInImage(
                                                          image: NetworkImage(
                                                              '${Environments.apiBaseURL}storage/images/${value.appointmentList[index].userInfo!.cover.toString()}'),
                                                          placeholder:
                                                              const AssetImage(
                                                                  "assets/images/placeholder.jpeg"),
                                                          imageErrorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image.asset(
                                                              'assets/images/notfound.png',
                                                              fit: BoxFit.cover,
                                                              height: 25,
                                                              width: 25,
                                                            );
                                                          },
                                                          fit: BoxFit.cover,
                                                          height: 25,
                                                          width: 25,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${value.appointmentList[index].userInfo!.firstName} ${value.appointmentList[index].userInfo!.lastName}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'bold',
                                                              fontSize: 12,
                                                              color: ThemeProvider
                                                                  .blackColor),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                value.appointmentList[index].appointmentsTo ==
                                                                        1
                                                                    ? '${value.appointmentList[index].address!.house} ${value.appointmentList[index].address!.address} ${value.appointmentList[index].address!.landmark} ${value.appointmentList[index].address!.pincode}'
                                                                    : 'At Salon'
                                                                        .tr,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: ThemeProvider
                                                                        .blackColor),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          "Appointments ID #"
                                                                  .tr +
                                                              value
                                                                  .appointmentList[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              color: ThemeProvider
                                                                  .blackColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 1,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: ThemeProvider
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  value
                                                          .appointmentList[
                                                              index]
                                                          .items!
                                                          .services!
                                                          .isNotEmpty
                                                      ? Text(
                                                          'Services'.tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'bold',
                                                              fontSize: 12,
                                                              color: ThemeProvider
                                                                  .blackColor),
                                                        )
                                                      : const SizedBox(),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: List.generate(
                                                        value
                                                            .appointmentList[
                                                                index]
                                                            .items!
                                                            .services!
                                                            .length,
                                                        (serviceIndex) => Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  value
                                                                      .appointmentList[
                                                                          index]
                                                                      .items!
                                                                      .services![
                                                                          serviceIndex]
                                                                      .name
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'regular',
                                                                      fontSize:
                                                                          10,
                                                                      color: ThemeProvider
                                                                          .blackColor),
                                                                ),
                                                                RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: value.currencySide ==
                                                                                'left'
                                                                            ? value.currencySymbol +
                                                                                value.appointmentList[index].items!.services![serviceIndex].price.toString()
                                                                            : value.appointmentList[index].items!.services![serviceIndex].price.toString() + value.currencySymbol,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                ThemeProvider.blackColor,
                                                                            decoration: TextDecoration.lineThrough),
                                                                      ),
                                                                      const TextSpan(
                                                                          text:
                                                                              ' '),
                                                                      TextSpan(
                                                                        text: value.currencySide ==
                                                                                'left'
                                                                            ? value.currencySymbol +
                                                                                value.appointmentList[index].items!.services![serviceIndex].off.toString()
                                                                            : value.appointmentList[index].items!.services![serviceIndex].off.toString() + value.currencySymbol,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                ThemeProvider.blackColor,
                                                                            fontFamily: 'bold'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  value
                                                          .appointmentList[
                                                              index]
                                                          .items!
                                                          .packages!
                                                          .isNotEmpty
                                                      ? Text(
                                                          'Packages'.tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'bold',
                                                              fontSize: 12,
                                                              color: ThemeProvider
                                                                  .blackColor),
                                                        )
                                                      : const SizedBox(),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: List.generate(
                                                        value
                                                            .appointmentList[
                                                                index]
                                                            .items!
                                                            .packages!
                                                            .length,
                                                        (packageIndex) =>
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      value
                                                                          .appointmentList[
                                                                              index]
                                                                          .items!
                                                                          .packages![
                                                                              packageIndex]
                                                                          .name
                                                                          .toString(),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'regular',
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              ThemeProvider.blackColor),
                                                                    ),
                                                                    RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text: value.currencySide == 'left'
                                                                                ? value.currencySymbol + value.appointmentList[index].items!.packages![packageIndex].price.toString()
                                                                                : value.appointmentList[index].items!.packages![packageIndex].price.toString() + value.currencySymbol,
                                                                            style: const TextStyle(
                                                                                fontSize: 10,
                                                                                color: ThemeProvider.blackColor,
                                                                                decoration: TextDecoration.lineThrough),
                                                                          ),
                                                                          const TextSpan(
                                                                              text: ' '),
                                                                          TextSpan(
                                                                            text: value.currencySide == 'left'
                                                                                ? value.currencySymbol + value.appointmentList[index].items!.packages![packageIndex].off.toString()
                                                                                : value.appointmentList[index].items!.packages![packageIndex].off.toString() + value.currencySymbol,
                                                                            style: const TextStyle(
                                                                                fontSize: 10,
                                                                                color: ThemeProvider.blackColor,
                                                                                fontFamily: 'bold'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: List
                                                                      .generate(
                                                                          value
                                                                              .appointmentList[index]
                                                                              .items!
                                                                              .packages![packageIndex]
                                                                              .services!
                                                                              .length,
                                                                          (packageServiceIndex) => Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  const Text('-', style: TextStyle(fontSize: 8, fontFamily: 'regular', color: ThemeProvider.blackColor)),
                                                                                  Text(
                                                                                    value.appointmentList[index].items!.packages![packageIndex].services![packageServiceIndex].name.toString(),
                                                                                    style: const TextStyle(fontSize: 8, fontFamily: 'regular', color: ThemeProvider.blackColor),
                                                                                  )
                                                                                ],
                                                                              )),
                                                                )
                                                              ],
                                                            )),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                height: 1,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: ThemeProvider
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Grand Total :'.tr,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'bold',
                                                        color: ThemeProvider
                                                            .blackColor),
                                                  ),
                                                  Text(
                                                    value.currencySide == 'left'
                                                        ? value.currencySymbol +
                                                            value
                                                                .appointmentList[
                                                                    index]
                                                                .grandTotal
                                                                .toString()
                                                        : value
                                                                .appointmentList[
                                                                    index]
                                                                .grandTotal
                                                                .toString() +
                                                            value
                                                                .currencySymbol,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'bold',
                                                        color: ThemeProvider
                                                            .blackColor),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                height: 1,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: ThemeProvider
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Appointment at :'.tr,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: ThemeProvider
                                                            .appColor),
                                                  ),
                                                  Text(
                                                    '${value.appointmentList[index].saveDate} ${value.appointmentList[index].slot}',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  )
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
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/no-data.png',
                                        width: 60, height: 60),
                                    const SizedBox(height: 30),
                                    Text(
                                      'No Appointment Found!'.tr,
                                      style: const TextStyle(
                                          fontFamily: 'bold',
                                          color: ThemeProvider.appColor),
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

  void _onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final DateTime currentViewDate = visibleDatesChangedDetails
          .visibleDates[visibleDatesChangedDetails.visibleDates.length ~/ 2];

      if (currentViewDate.month == DateTime.now().month &&
          currentViewDate.year == DateTime.now().year) {
        _calendarController.selectedDate = DateTime.now();
      } else {
        _calendarController.selectedDate =
            DateTime(currentViewDate.year, currentViewDate.month);
      }
    });
    _calendarController.addPropertyChangedListener((event) {
      debugPrint(_calendarController.selectedDate.toString());
      Get.find<CalendarsController>()
          .getByDate(_calendarController.selectedDate.toString());
    });
  }

  SfCalendar _getAgendaViewCalendar(
      [CalendarDataSource? calendarDataSource,
      ViewChangedCallback? onViewChanged,
      CalendarController? controller]) {
    return SfCalendar(
      view: CalendarView.month,
      controller: controller,
      showDatePickerButton: true,
      onViewChanged: onViewChanged,
      backgroundColor: ThemeProvider.whiteColor,
      dataSource: calendarDataSource,
      monthViewSettings:
          const MonthViewSettings(showAgenda: false, numberOfWeeksInView: 4),
      timeSlotViewSettings: const TimeSlotViewSettings(
          minimumAppointmentDuration: Duration(minutes: 60)),
    );
  }
}

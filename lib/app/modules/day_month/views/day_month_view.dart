import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ial_wallet/app/modules/days_all/views/days_all_view.dart';
import 'package:ial_wallet/app/modules/days_daily/views/days_daily_view.dart';
import 'package:ial_wallet/app/modules/days_frequency/views/days_frequency_view.dart';
import 'package:ial_wallet/app/modules/days_zakat/views/days_zakat_view.dart';
import 'package:ial_wallet/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../controllers/day_month_controller.dart';

class DayMonthView extends GetView<DayMonthController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: Text('LIST DAYS IN MONTH'),
            centerTitle: true,
            bottom: TabBar(indicatorColor: Colors.white, tabs: [
              Tab(text: "All"),
              Tab(text: "Daily"),
              Tab(text: "Frequency"),
              Tab(text: "Zakat"),
            ]),
          ),
          body: TabBarView(
            children: [
              DaysAllView(),
              DaysDailyView(),
              DaysFrequencyView(),
              DaysZakatView(),
            ],
          )),
    );
  }
}

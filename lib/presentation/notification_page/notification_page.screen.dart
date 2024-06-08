import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widget/common/main_container_widget.dart';
import 'package:wash_it/widget/common/mainpage_appbar_widget.dart';

import 'controllers/notification_page.controller.dart';

class NotificationPageScreen extends GetView<NotificationPageController> {
  const NotificationPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainpageAppbarWidget(
        title: 'Notifikasi',
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context, index) => MainNotificationWidget(),
            )
          ],
        ),
      ),
    );
  }
}

class MainNotificationWidget extends StatelessWidget {
  const MainNotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultMargin),
      child: MainContainerWidget(
        childs: Padding(
          padding: const EdgeInsets.all(defaultMargin),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.red),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Laundry telah selesai',
                      style: tsBodySmallSemibold(black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '2 Jam yang lalu',
                          style: tsBodySmallMedium(darkGrey),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: darkGrey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                        Text(
                          'Orderan',
                          style: tsBodySmallMedium(darkGrey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

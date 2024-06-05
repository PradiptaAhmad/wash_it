import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/onboarding_page/slider.dart';

import '../../infrastructure/navigation/routes.dart';

class BoardingScreen extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  int _currentPage = 0;
  PageController _controller = PageController();

  List<Widget> _pages = [
    SliderPage(
      titleWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Semuanya Mudah",
            style: tsTitleLargeSemibold(Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Aplikasi laundry hadir dengan fitur yang \n memudahkan kita dalam mengelola \n laundry",
            style: tsBodyMediumRegular(Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      image: "assets/bg_boarding/bg_boarding1.png",
    ),
    SliderPage(
      titleWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Kebersihan Tanpa Repot",
            style: tsTitleLargeSemibold(Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Mulai dari pakaian sehari-hari hingga pakaian formal, kami akan mengurus semuanya untuk Anda dengan cepat dan efisien.",
            style: tsBodyMediumRegular(Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      image: "assets/bg_boarding/bg_boarding2.png",
    ),
    SliderPage(
      titleWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Praktis & Gak Ribet",
            style: tsTitleLargeSemibold(Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Gaperlu jemput pakaian sendiri cukup klik semua pakaian kamu kembali seperti baru beli",
            style: tsBodyMediumRegular(Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      image: "assets/bg_boarding/bg_boarding3.png",
    ),
  ];

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onchanged,
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(_pages.length, (int index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 10,
                    width: (index == _currentPage) ? 30 : 10,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: (index == _currentPage)
                          ? Colors.black
                          : Colors.grey.withOpacity(0.5),
                    ),
                  );
                }),
              ),
              InkWell(
                onTap: () {
                  if (_currentPage == (_pages.length - 1)) {
                    Get.toNamed(Routes.REGISTER_PAGE);
                  } else {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOutQuint,
                    );
                  }
                },
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  duration: Duration(milliseconds: 300),
                  height: 70,
                  width: (_currentPage == (_pages.length - 1)) ? 200 : 75,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: (_currentPage == (_pages.length - 1))
                      ? Text(
                          "Daftar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )
                      : Icon(
                          Icons.navigate_next,
                          size: 50,
                          color: Colors.white,
                        ),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ],
      ),
    );
  }
}

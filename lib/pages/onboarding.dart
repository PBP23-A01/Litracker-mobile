// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:litracker_mobile/data/onboarding_data.dart';
import 'package:litracker_mobile/pages/auth/login_page.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(81, 33, 255, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: listKonten.length,
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              itemBuilder: (_, i) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 60.0,
                        left: 40.0,
                        right: 40.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listKonten[i].title,
                            style: const TextStyle(
                              fontFamily: 'SF-Pro',
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            listKonten[i].desc,
                            style: const TextStyle(
                              fontFamily: 'SF-Pro',
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.asset(
                          listKonten[i].bg,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Baris statis di luar PageView
          Container(
            padding: const EdgeInsets.only(
              left: 40,
              right: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listKonten.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPage == index
                              ? Colors.white
                              : const Color.fromRGBO(72, 22, 236, 1),
                        ),
                      );
                    },
                  ),
                ),
                // Tombol ke halaman berikutnya
                GestureDetector(
                  onTap: () {
                    if (currentPage < listKonten.length - 1) {
                      _pageController.animateToPage(
                        currentPage + 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: currentPage < listKonten.length - 1 ? 56 : 160,
                    height: 56,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(31, 105, 255, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: currentPage < listKonten.length - 1
                        ? Image.asset(
                            'assets/images/arrow-right.png',
                          )
                        : const Text(
                            "Mulai Jelajah",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'SF-Pro',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.7,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          // Add a SizedBox with a specific height to reduce space after PageView
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

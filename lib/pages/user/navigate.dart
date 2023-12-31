// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:litracker_mobile/pages/user/home.dart';
import '../../reading_history/screens/history.dart'; // Import your HistoryContent class

import 'profile.dart';
import 'package:litracker_mobile/review/review_book.dart';

class NavigateUser extends StatefulWidget {
  const NavigateUser({Key? key}) : super(key: key);

  @override
  _NavigateUserState createState() => _NavigateUserState();
}

class _NavigateUserState extends State<NavigateUser> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 247, 249, 1),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Content that can be scrolled
                  _getContentWidget(),
                ],
              ),
            ),
          ),
          _buildCustomNavigationBar(),
        ],
      ),
    );
  }

  Widget _getContentWidget() {
    switch (_currentIndex) {
      case 0:
        return const HomeContent();
      case 1:
        return const ReviewContent();
      case 2:
        return const HistoryContent();
      case 3:
        return ProfileContent();
      default:
        return Container();
    }
  }

  Widget _buildCustomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(72, 22, 236, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 32,
        left: 40,
        right: 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(0, 'Beranda', 'assets/navbar/home-secondary.png', 'assets/navbar/home-primary.png'),
          _buildNavItem(1, 'Ulas', 'assets/navbar/review-secondary.png', 'assets/navbar/review-primary.png'),
          _buildNavItem(2, 'Riwayat', 'assets/navbar/history-secondary.png', 'assets/navbar/history-primary.png'),
          _buildNavItem(3, 'Profil', 'assets/navbar/profile-secondary.png', 'assets/navbar/profile-primary.png'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String label, String imagePath, String activeImagePath) {
    bool isSelected = index == _currentIndex;

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Hero(
        tag: 'navItem_$index',
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 40,
                height: isSelected ? 44 : 36,
                child: Image.asset(
                  isSelected ? activeImagePath : imagePath,
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                height: isSelected ? 4 : 24,
              ),
              Visibility(
                visible: isSelected,
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'SF-Pro',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

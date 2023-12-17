import 'package:flutter/material.dart';
import 'package:litracker_mobile/pages/user/detailReview.dart';

class ReviewContent extends StatefulWidget {
  @override
  _ReviewContentState createState() => _ReviewContentState();
}

class _ReviewContentState extends State<ReviewContent> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          color: Color.fromRGBO(246, 247, 249, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, right: 40, left: 40),
                child: const Text(
                  "Ulasan Buku",
                  style: TextStyle(
                    fontFamily: 'SF-Pro',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(236, 239, 242, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Image.asset("assets/review/search.png"),
                              const SizedBox(
                                width: 16,
                              ),
                              const Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Cari Buku",
                                    hintStyle: TextStyle(
                                      fontFamily: 'SF-Pro',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -1,
                                      color: Color.fromRGBO(101, 122, 146, 1),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(186, 191, 255, 1),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(right: 12),
                      tabs: [
                        _buildTab("Semua Ulasan", 0),
                        _buildTab("Ulasan Saya", 1),
                      ],
                      onTap: (index) {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                      },
                      indicator: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.0, color: Colors.transparent)),
                      ),
                      indicatorWeight: 0.0,
                      indicatorColor: Colors.transparent,
                      labelColor: Colors.white,
                      unselectedLabelColor:
                          const Color.fromRGBO(101, 122, 146, 1),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Material(
                            color: Color.fromRGBO(246, 247, 249, 1),
                            child: SingleChildScrollView(
                              // Wrap with SingleChildScrollView
                              child: Container(
                                padding: const EdgeInsets.only(top: 24),
                                color: Color.fromRGBO(246, 247, 249, 1),
                                child: Column(
                                  children: [
                                    // Content for the "Semua Ulasan" tab
                                    _buildReviewContent(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Color.fromRGBO(246, 247, 249, 1),
                            child: SingleChildScrollView(
                              // Wrap with SingleChildScrollView
                              child: Container(
                                padding: const EdgeInsets.only(top: 24),
                                color: Color.fromRGBO(246, 247, 249, 1),
                                child: Column(
                                  children: [
                                    // Content for the "Semua Ulasan" tab
                                    _buildReviewContent(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildTab(String text, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: _selectedTabIndex == index
                  ? const Color.fromRGBO(81, 23, 255, 1)
                  : Colors.white,
              // border: Border.all(
              //     color: _selectedTabIndex == index
              //         ? Colors.transparent
              //         : const Color.fromRGBO(213, 219, 226, 1),
              //     width: 1),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: _selectedTabIndex == index
                    ? Colors.white
                    : const Color.fromRGBO(101, 122, 146, 1),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }

  Widget _buildReviewContent() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        // border: Border.all(
        //   color: Color.fromRGBO(236, 239, 242, 1),
        // )
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/review/dummy-book.png'),
              const SizedBox(
                width: 12,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nature Kingdom",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: 'SF-Pro',
                          fontSize: 16,
                          letterSpacing: -0.7,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(8, 4, 22, 1)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Clove Griffith",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: 'SF-Pro',
                          fontSize: 14,
                          letterSpacing: -0.7,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(132, 151, 172, 1)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromRGBO(246, 247, 249, 1),
            ),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/review/profile-picture.png",
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "rozieistripopo",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.3,
                                  color: Color.fromRGBO(132, 151, 172, 1)),
                            ),
                            Text(
                              "Buku keren",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                  color: Color.fromRGBO(66, 80, 98, 1)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/review/profile-picture.png",
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "rozieistripopo",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.3,
                                  color: Color.fromRGBO(132, 151, 172, 1)),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Buku keren",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'SF-Pro',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                  color: Color.fromRGBO(66, 80, 98, 1)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/review/profile-picture.png",
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "rozieistripopo",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.3,
                                  color: Color.fromRGBO(132, 151, 172, 1)),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Aku bacanya sampe ngantuk sumpah recommended abis cuyyyyy",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'SF-Pro',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                  color: Color.fromRGBO(66, 80, 98, 1)),
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
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "67 ulasan",
                style: TextStyle(
                    fontFamily: 'SF-Pro',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(132, 151, 172, 1)),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color.fromRGBO(81, 33, 255, 1),
                ),
                child: GestureDetector(
                  // onTap: () {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) => const DetailReview()));
                  // },
                  child: Image.asset(
                    "assets/review/right-arrow.png",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:litracker_mobile/pages/user/utils/color_choice.dart';
import 'package:litracker_mobile/reading_history/screens/last_page_form.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;

  BookDetailPage({required this.book});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool isVoted = false;
  int total = 0;
  // Paling atas untuk upvote
  Widget totalUpvoteStyle() {
    return Container(
      width: 200,
      alignment: Alignment.center,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(28)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/home/upvote.png",
            width: 36,
            height: 36,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "$total upvote buku ini",
            style: TextStyle(
                fontFamily: 'SF-Pro',
                letterSpacing: -0.7,
                fontSize: 12,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  // Buku
  Widget imageBookStyle() {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12)),
        child: Image.network(
          widget.book.fields.imageUrlL.replaceFirst(
              "http://images.amazon.com/", "https://m.media-amazon.com/"),
          width: 184,
          height: 232,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Shadow buku
  Widget year() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: jaguar700,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Text(
        widget.book.fields.publishedYear.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'SF-Pro',
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: Colors.white),
      ),
    );
  }

  // Atur add to wishlist
  Widget userAddToWishlist() {
    return Container(
        child: Image.asset(
      "assets/home/wishlist_blank.png",
      width: 36,
      height: 36,
    ));
  }

  // Judul buku
  Widget titleBook() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        widget.book.fields.title,
        style: TextStyle(
            fontFamily: 'SF-Pro',
            fontWeight: FontWeight.w900,
            fontSize: 32,
            color: jaguar950),
      ),
    );
  }

  // Author
  Widget authorofBook() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        widget.book.fields.author,
        style: TextStyle(
            fontFamily: 'SF-Pro',
            fontWeight: FontWeight.w700,
            color: kashmirBlue500,
            fontSize: 16),
      ),
    );
  }

  // ISBN
  Widget ISBN_ofBook() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
          color: kashmirBlue50,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        children: [
          Container(
            child: Text(
              "ISBN",
              style: TextStyle(
                  fontFamily: 'SF-Pro',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: kashmirBlue600),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Container(
            child: Text(
              widget.book.fields.isbn,
              style: TextStyle(
                  fontFamily: 'SF-Pro',
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: kashmirBlue950),
            ),
          ),
        ],
      ),
    );
  }

  // Back to Home
  Widget backtoHome() {
    return Container(
      child: Image.asset(
        "assets/home/back.png",
        width: 48,
        height: 48,
      ),
    );
  }

  // Has read book -> input number of page
  bool isRead = false;
  Widget readingHistory(theWidth) {
    return Container(
      width: theWidth,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
          color: jaguar400,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Text(
        "Tandai Sedang Dibaca",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'SF-Pro',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    // BG Grey -> Buku
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: kashmirBlue100,
                        padding: EdgeInsets.only(
                          top: 60,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              totalUpvoteStyle(),
                              SizedBox(
                                height: 24,
                              ),
                              imageBookStyle(),
                              SizedBox(
                                height: 20,
                              )
                            ]),
                      ),
                    ),
                    Container(
                      color: kashmirBlue100,
                      height: 40,
                      child: Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                      ),
                    ),
                    // BG White -> Informasi Buku
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                year(),
                                Row(
                                  children: [
                                    userAddToWishlist(),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    GestureDetector(
                                      // Inside the onTap method for upvote
                                      // Inside the onTap method for upvote
                                      onTap: () async {
                                        final response = await request.post(
                                            "http://localhost:8080/upvote_book/toggle_upvote_flutter/${widget.book.pk}/",
                                            {});

                                        // Check if the book is upvoted or unvoted

                                        String message = response['message'];
                                        int total_votes =
                                            response['total_votes'];
                                        if (message == 'Upvoted' ||
                                            message == 'Unvoted') {
                                          setState(() {
                                            if (message == 'Upvoted') {
                                              isVoted = true;
                                              total = total_votes;
                                            } else {
                                              isVoted = false;
                                              total = total_votes;
                                            }
                                          });
                                        }
                                      },

                                      child: Container(
                                          child: Image.asset(
                                        isVoted
                                            ? "assets/home/upvote_fill.png"
                                            : "assets/home/upvote_blank.png",
                                        width: 36,
                                        height: 36,
                                      )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                titleBook(),
                                SizedBox(
                                  height: 8,
                                ),
                                authorofBook(),
                                SizedBox(
                                  height: 24,
                                ),
                                ISBN_ofBook(),
                                SizedBox(
                                  height: 160,
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
            ), // Mulai dari sini
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding:
                    EdgeInsets.only(top: 20, bottom: 60, left: 40, right: 40),
                decoration: BoxDecoration(
                    color: jaguar700,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: backtoHome()),
                    SizedBox(
                      width: 24,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LastPageForm()),
                          );
                        },
                        child: readingHistory(
                            MediaQuery.of(context).size.width - 196)),
                    SizedBox(
                      width: 24,
                    ),
                  ],
                ),
              ),
            )
            // Sampai sini
          ],
        ),
      ),
    );
  }
}

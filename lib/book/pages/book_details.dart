// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:litracker_mobile/data/models/user.dart';
import 'package:litracker_mobile/review/detailReview.dart';
import 'package:litracker_mobile/pages/user/utils/color_choice.dart';
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
  int totalUpvotedBookbyUser = 0;
  bool isWishlisted = false;
  int totalWishlistedBookbyUser = 0;
  int _lastPage = 0;
  late Future<int> averageRating;

  @override
  void initState() {
    super.initState();
    averageRating = fetchTotalRating(widget.book.pk);
  }

  Future<int> fetchTotalRating(bookID) async {
    final requestTotalUsers =
        Provider.of<CookieRequest>(context, listen: false);
    final responseUsersVote = await requestTotalUsers.get(
        'https://litracker-a01-tk.pbp.cs.ui.ac.id/review_book/get_total_rating/${bookID}/');

    return responseUsersVote['average_rating'];
  }

  Future<int> fetchTotalUsersVote() async {
    final requestTotalUsers =
        Provider.of<CookieRequest>(context, listen: false);
    final responseUsersVote = await requestTotalUsers.get(
        'https://litracker-a01-tk.pbp.cs.ui.ac.id/upvote_book/get_upvoting_users/${widget.book.pk}');

    return responseUsersVote['total_users_upvote'];
  }

  Future<bool> fetchHasUserUpvoted() async {
    final requestTotalUsers =
        Provider.of<CookieRequest>(context, listen: false);
    final responseUsersVote = await requestTotalUsers.get(
        'https://litracker-a01-tk.pbp.cs.ui.ac.id/upvote_book/get_upvoting_users/${widget.book.pk}');

    return responseUsersVote['isUpvote'];
  }

  Future<int> fetchTotalUsersWishlist() async {
    final requestTotalUsers =
        Provider.of<CookieRequest>(context, listen: false);
    final responseUsersWishlist = await requestTotalUsers.get(
        'https://litracker-a01-tk.pbp.cs.ui.ac.id/favorite_book/get_wishlisting_users/${widget.book.pk}');

    return responseUsersWishlist['total_users_wishlist'];
  }

  Future<bool> fetchHasUserWishlisted() async {
    final requestTotalUsers =
        Provider.of<CookieRequest>(context, listen: false);
    final responseUsersWishlist = await requestTotalUsers.get(
        'https://litracker-a01-tk.pbp.cs.ui.ac.id/favorite_book/get_wishlisting_users/${widget.book.pk}');

    return responseUsersWishlist['isWishlist'];
  }

  void showSuccessNotification(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.all(4),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: jaguar400,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white, // Anda dapat menyesuaikan warnanya
                ),
              ),
              SizedBox(width: 8.0), // Jarak antara ikon dan teks
              Text(
                'Berhasil Disimpan',
                style: TextStyle(
                  fontFamily: 'SF-Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: jaguar600, // Anda dapat menyesuaikan warnanya
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.85,
            left: 40,
            right: 40),
      ),
    );
  }

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
            "$totalUpvotedBookbyUser upvote buku ini",
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

  // Star
  Widget rating(Future<int> averageRating) {
    return Row(
      children: [
        Image.asset(
          "assets/review/rating.png",
          width: 20,
          height: 20,
        ),
        SizedBox(
          width: 12,
        ),
        FutureBuilder<int>(
          future: averageRating,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Display loading indicator while fetching data
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Container(
                child: Text(
                  '${snapshot.data}/5',
                  style: TextStyle(
                      fontFamily: 'SF-Pro',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: jaguar950),
                ),
              );
            }
          },
        ),
      ],
    );
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

  // Back to Home
  Widget seeReviews() {
    return Container(
      child: Image.asset(
        "assets/home/seereviews.png",
        width: 48,
        height: 48,
      ),
    );
  }

  // Has read book -> input number of page
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
                              FutureBuilder<int>(
                                future: fetchTotalUsersVote(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    totalUpvotedBookbyUser = snapshot.data!;
                                    return totalUpvoteStyle();
                                  }
                                },
                              ),
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
                                    GestureDetector(
                                        onTap: () async {
                                          final requestToggleWishlist =
                                              Provider.of<CookieRequest>(
                                                  context,
                                                  listen: false);
                                          final response =
                                              await requestToggleWishlist.post(
                                                  "https://litracker-a01-tk.pbp.cs.ui.ac.id/favorite_book/toggle_wishlist_flutter/${widget.book.pk}/",
                                                  {});

                                          String message = response['message'];
                                          if (message == 'Wishlisted' ||
                                              message == 'Unwishlisted') {
                                            setState(() {
                                              if (message == 'Wishlisted') {
                                                fetchTotalUsersWishlist();
                                              } else {
                                                fetchTotalUsersWishlist();
                                              }
                                            });
                                          }
                                        },
                                        child: Container(
                                          child: FutureBuilder<bool>(
                                            future: fetchHasUserWishlisted(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else {
                                                isWishlisted = snapshot.data!;
                                                return Image.asset(
                                                  isWishlisted
                                                      ? "assets/home/wishlist_fill.png"
                                                      : "assets/home/wishlist_blank.png",
                                                  width: 36,
                                                  height: 36,
                                                );
                                              }
                                            },
                                          ),
                                        )),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    GestureDetector(
                                        // Inside the onTap method for upvote
                                        // Inside the onTap method for upvote
                                        onTap: () async {
                                          final requestToggleUpvote =
                                              Provider.of<CookieRequest>(
                                                  context,
                                                  listen: false);
                                          final response =
                                              await requestToggleUpvote.post(
                                                  "https://litracker-a01-tk.pbp.cs.ui.ac.id/upvote_book/toggle_upvote_flutter/${widget.book.pk}/",
                                                  {});

                                          // Check if the book is upvoted or unvoted

                                          String message = response['message'];
                                          // int total_votes =
                                          //     response['total_votes'];
                                          if (message == 'Upvoted' ||
                                              message == 'Unvoted') {
                                            setState(() {
                                              if (message == 'Upvoted') {
                                                // isVoted = true;
                                                // totalUpvotedBookbyUser =
                                                //     total_votes;
                                                fetchTotalUsersVote();
                                              } else {
                                                // isVoted = false;
                                                fetchTotalUsersVote();
                                              }
                                            });
                                          }
                                        },
                                        child: Container(
                                          child: FutureBuilder<bool>(
                                            future: fetchHasUserUpvoted(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else {
                                                isVoted = snapshot.data!;
                                                return Image.asset(
                                                  isVoted
                                                      ? "assets/home/upvote_fill.png"
                                                      : "assets/home/upvote_blank.png",
                                                  width: 36,
                                                  height: 36,
                                                );
                                              }
                                            },
                                          ),
                                        ))
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
                                rating(averageRating),
                                SizedBox(
                                  height: 20,
                                ),
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
                    EdgeInsets.only(top: 20, bottom: 60, left: 40, right: 20),
                decoration: BoxDecoration(
                    color: jaguar700,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: backtoHome()),
                    SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                        onTap: () async {
                          final _formKey = GlobalKey<FormState>();
                          final _controller = TextEditingController();

                          await showDialog<bool?>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Atur Nomor Halaman',
                                  style: TextStyle(
                                    fontFamily: 'SF-Pro',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -1,
                                    fontSize: 24,
                                    color: Color.fromRGBO(8, 4, 22, 1),
                                  ),
                                ),
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: const Color.fromRGBO(
                                              246, 247, 249, 1),
                                        ),
                                        child: TextFormField(
                                          controller: _controller,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Nomor halaman tidak boleh kosong!";
                                            }
                                            var parsedValue =
                                                int.tryParse(value);
                                            if (parsedValue == null ||
                                                parsedValue < 0) {
                                              return "Nomor halaman harus berupa angka!";
                                            }
                                            return null;
                                          },
                                          onChanged: (String? value) {
                                            setState(() {
                                              _lastPage = int.parse(value!);
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Nomor Halaman',
                                            labelStyle: const TextStyle(
                                              fontFamily: 'SF-Pro',
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: -0.8,
                                              color:
                                                  Color.fromRGBO(51, 59, 68, 1),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    208, 201, 255, 1),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 12),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor:
                                          const Color.fromRGBO(8, 4, 22, 1),
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 20,
                                      ),
                                    ),
                                    child: const Text(
                                      'Kembali',
                                      style: TextStyle(
                                        fontFamily: 'SF-Pro',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Color.fromRGBO(8, 4, 22, 1),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(72, 22, 236, 1),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 20,
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        // Define the URL of the view
                                        var url = Uri.parse(
                                            'https://litracker-a01-tk.pbp.cs.ui.ac.id/reading_history/post_reading_history/${widget.book.pk}/');

                                        var data = {
                                          'username': loggedInUser!.username,
                                          'last_page': _lastPage.toString(),
                                        };

                                        var response =
                                            await http.post(url, body: data);

                                        if (response.statusCode == 200) {
                                          Navigator.of(context).pop(true);
                                          showSuccessNotification(context);
                                        } else {
                                          print(response);
                                        }
                                      }
                                    },
                                    child: const Text(
                                      'Simpan',
                                      style: TextStyle(
                                        fontFamily: 'SF-Pro',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: readingHistory(
                            MediaQuery.of(context).size.width - 196)),
                    SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailReview(
                                  bookID: widget.book.pk,
                                  bookReviewed: widget.book)));
                        },
                        child: seeReviews()),
                    SizedBox(
                      width: 12,
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

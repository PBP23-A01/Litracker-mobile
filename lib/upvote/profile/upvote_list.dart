// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, use_super_parameters

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:litracker_mobile/pages/user/utils/color_choice.dart';

class UpvotedBook {
  final int id;
  final String isbn;
  final String title;
  final String author;
  final int publishedYear;
  final String publisher;
  final String imageUrlS;
  final String imageUrlM;
  final String imageUrlL;
  final int totalUpvoteThisBook;

  UpvotedBook({
    required this.id,
    required this.isbn,
    required this.title,
    required this.author,
    required this.publishedYear,
    required this.publisher,
    required this.imageUrlS,
    required this.imageUrlM,
    required this.imageUrlL,
    required this.totalUpvoteThisBook,
  });
}

class UpVoteList extends StatefulWidget {
  const UpVoteList({Key? key}) : super(key: key);

  @override
  _UpVoteListState createState() => _UpVoteListState();
}

class _UpVoteListState extends State<UpVoteList> {
  bool isLoading = false;
  Map<String, bool> bookLoadingStates = {};

  Future<List<UpvotedBook>> fetchUpvotedBooks() async {
    final requestUpvotedBooks =
        Provider.of<CookieRequest>(context, listen: false);
    final responseUpvotedBooks = await requestUpvotedBooks
        .get('https://litracker-a01-tk.pbp.cs.ui.ac.id/upvote_book/get_upvoted_books');

    List<UpvotedBook> fetchedUpvotedBooks = [];

    for (var bookData in responseUpvotedBooks['upvoted_books']) {
      UpvotedBook upvotedBook = UpvotedBook(
        id: bookData['id'],
        isbn: bookData['isbn'],
        title: bookData['title'],
        author: bookData['author'],
        publishedYear: bookData['published_year'],
        publisher: bookData['publisher'],
        imageUrlS: bookData['image_url_s'],
        imageUrlM: bookData['image_url_m'],
        imageUrlL: bookData['image_url_l'],
        totalUpvoteThisBook: bookData['total_upvote_thisbook'],
      );

      fetchedUpvotedBooks.add(upvotedBook);
    }

    return fetchedUpvotedBooks;
  }

  void showSuccessNotification(bookName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                    color: jaguar400,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.white, // Anda dapat menyesuaikan warnanya
                ),
              ),
              const SizedBox(width: 8.0), // Jarak antara ikon dan teks
              const Text(
                'Berhasil diunvote!',
                style: TextStyle(
                  fontFamily: 'SF-Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 2),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 247, 249, 1),
      body: SingleChildScrollView(
        child: Container(
          // width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/upvote/left-arrow.png",
                      width: 36,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "Buku Terupvote",
                    style: TextStyle(
                      fontFamily: 'SF-Pro',
                      letterSpacing: -0.7,
                      color: Color.fromRGBO(
                        8,
                        4,
                        22,
                        1,
                      ),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              FutureBuilder<List<UpvotedBook>>(
                future: fetchUpvotedBooks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<UpvotedBook> upvotedBooks = snapshot.data ?? [];
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: upvotedBooks.length,
                      itemBuilder: (context, index) {
                        return cardBook(context, upvotedBooks[index]);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardBook(BuildContext context, UpvotedBook book) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(6),
                        bottomLeft: Radius.circular(2),
                        bottomRight: Radius.circular(6)),
                    child: Image.network(
                      book.imageUrlL.replaceFirst("http://images.amazon.com/",
                          "https://m.media-amazon.com/"),
                      width: 52,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'SF-Pro',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color.fromRGBO(8, 4, 22, 1),
                          letterSpacing: -0.7,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        book.author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'SF-Pro',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color.fromRGBO(132, 151, 172, 1),
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 247, 249, 1),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Image.asset("assets/upvote/upvote-36.png"),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            book.totalUpvoteThisBook.toString(),
                            style: const TextStyle(
                              fontFamily: 'SF-Pro',
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Color.fromRGBO(8, 4, 22, 1),
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title: const Text(
                                'Yakin ingin membatalkan upvote?',
                                style: TextStyle(
                                  fontFamily: 'SF-Pro',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -1,
                                  fontSize: 24,
                                  color: Color.fromRGBO(8, 4, 22, 1),
                                ),
                              ),
                              content: const Text(
                                'Tekan OK untuk melanjutkan',
                                style: TextStyle(
                                  fontFamily: 'SF-Pro',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromRGBO(88, 107, 132, 1),
                                ),
                              ),
                              backgroundColor: Colors.white,
                              buttonPadding: const EdgeInsets.all(16),
                              contentPadding: const EdgeInsets.only(
                                bottom: 40,
                                left: 24,
                                top: 12,
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
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        const Color.fromRGBO(72, 22, 236, 1),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 20,
                                    ),
                                  ),
                                  child: bookLoadingStates[book.isbn] ?? false
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text('OK'),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    final requestToggleUpvote =
                                        Provider.of<CookieRequest>(context,
                                            listen: false);
                                    final response = await requestToggleUpvote.post(
                                        "https://litracker-a01-tk.pbp.cs.ui.ac.id/upvote_book/toggle_upvote_flutter/${book.id}/",
                                        {});

                                    String message = response['message'];
                                    setState(() {
                                      if (message == 'Unvoted') {
                                        bookLoadingStates[book.isbn] = true;
                                        showSuccessNotification(book.title);
                                      }
                                    });

                                    // Simulate loading
                                    await Future.delayed(const Duration(seconds: 1));

                                    setState(() {
                                      // Reset loading state for the current book
                                      bookLoadingStates[book.isbn] = false;
                                    });

                                    // Show success notification
                                  },
                                ),
                              ]),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isLoading
                              ? Colors.grey
                              : const Color.fromRGBO(81, 33, 255, 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: 36,
                        width: 88,
                        alignment: Alignment.center,
                        child: isLoading
                            ? const SizedBox(
                                height: 28,
                                width: 28,
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 4,
                                  // You can set a different color here
                                  // color: Colors.white,
                                ),
                              )
                            : const Text(
                                "Batalkan",
                                style: TextStyle(
                                  fontFamily: 'SF-Pro',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}

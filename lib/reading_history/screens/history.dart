import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:litracker_mobile/data/models/user.dart';
import 'package:litracker_mobile/pages/user/utils/color_choice.dart';
import 'package:litracker_mobile/reading_history/models/seehistory.dart';
import 'package:litracker_mobile/reading_history/utils/reading_history_utils.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class HistoryContent extends StatefulWidget {
  const HistoryContent({Key? key});

  @override
  State<HistoryContent> createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  late int lastPage;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<List<ReadingHistory>> fetchReadingHistories() async {
    final requestReadingHistories =
        Provider.of<CookieRequest>(context, listen: false);
    final responseReadingHistories = await requestReadingHistories.get(
        'https://litracker-a01-tk.pbp.cs.ui.ac.id/reading_history/get_all_reading_history/');

    List<ReadingHistory> fetchedReadingHistories = [];

    for (var historyData in responseReadingHistories['reading_histories']) {
      ReadingHistory readingHistory = ReadingHistory(
        id: historyData['id'],
        bookId: historyData['book_id'],
        bookTitle: historyData['book_title'],
        bookAuthor: historyData['book_author'],
        username: historyData['username'],
        lastPage: historyData['last_page'],
        dateOpened: DateTime.parse(historyData['date_opened']),
      );

      fetchedReadingHistories.add(readingHistory);
    }

    return fetchedReadingHistories;
  }

  Future<void> saveLastPage(int bookId, int lastPage) async {
    // Define the URL of the view
    var url = Uri.parse(
        'https://litracker-a01-tk.pbp.cs.ui.ac.id/reading_history/post_reading_history/$bookId/');

    var data = {
      'username': loggedInUser!.username,
      'last_page': lastPage.toString(),
    };

    var response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      // Berhasil menyimpan, bisa menampilkan notifikasi atau melakukan tindakan lainnya
      setState(() {});
    } else {
      // Gagal menyimpan, bisa menampilkan pesan kesalahan atau melakukan tindakan lainnya
      showConfirmationDialog(context, 'Gagal menyimpan nomor halaman');
    }
  }

  Future<void> deleteReadingHistory(int bookId) async {
    final cookieRequest = Provider.of<CookieRequest>(context, listen: false);
    final String url =
        'https://litracker-a01-tk.pbp.cs.ui.ac.id/reading_history/delete_reading_history/$bookId/';

    try {
      await cookieRequest.post(url, {});

      // Reload the reading histories after successful deletion
      setState(() {});

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
                  'Berhasil dihapus!',
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
    } catch (error) {
      print('Error deleting reading history: $error');
      // Handle error scenarios here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Riwayat Bacaan",
            style: TextStyle(
                fontFamily: 'SF-Pro',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: jaguar950,
                letterSpacing: -0.7),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Nomor Tersimpan",
            style: TextStyle(
                fontFamily: 'SF-Pro',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: kashmirBlue600),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder<List<ReadingHistory>>(
          future: fetchReadingHistories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                snapshot.data!.map((ReadingHistory history) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.all(12),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.topLeft,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(80, 166, 255, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                      ),
                                      child: Text(
                                        history.lastPage.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'SF-Pro',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                240,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              history.bookTitle,
                                              style: const TextStyle(
                                                color:
                                                    Color.fromRGBO(8, 4, 22, 1),
                                                fontFamily: 'SF-Pro',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              history.bookAuthor,
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    132, 151, 172, 1),
                                                fontFamily: 'SF-Pro',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            bool? result =
                                                await showDialog<bool?>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    'Atur Nomor Halaman',
                                                    style: TextStyle(
                                                      fontFamily: 'SF-Pro',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: -1,
                                                      fontSize: 24,
                                                      color: Color.fromRGBO(
                                                          8, 4, 22, 1),
                                                    ),
                                                  ),
                                                  content: Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            color: const Color
                                                                .fromRGBO(246,
                                                                247, 249, 1),
                                                          ),
                                                          child: Form(
                                                            key: formKey,
                                                            child:
                                                                TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Nomor Halaman',
                                                                labelStyle:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      'SF-Pro',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  letterSpacing:
                                                                      -0.8,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          51,
                                                                          59,
                                                                          68,
                                                                          1),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            208,
                                                                            201,
                                                                            255,
                                                                            1),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            16,
                                                                        vertical:
                                                                            12),
                                                              ),
                                                              onSaved: (value) {
                                                                lastPage =
                                                                    int.parse(
                                                                        value!);
                                                              },
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
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            const Color
                                                                .fromRGBO(
                                                                8, 4, 22, 1),
                                                        backgroundColor:
                                                            Colors.white,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 24,
                                                          vertical: 20,
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Kembali',
                                                        style: TextStyle(
                                                          fontFamily: 'SF-Pro',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Color.fromRGBO(
                                                              8, 4, 22, 1),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      },
                                                    ),
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            const Color
                                                                .fromRGBO(
                                                                72, 22, 236, 1),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 24,
                                                          vertical: 20,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        formKey.currentState
                                                            ?.save();
                                                        saveLastPage(
                                                            history.bookId,
                                                            lastPage);
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      },
                                                      child: const Text(
                                                        'Simpan',
                                                        style: TextStyle(
                                                          fontFamily: 'SF-Pro',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                            if (result != null && result) {
                                              // Logic setelah menyimpan
                                            }
                                          },
                                          child: Image.asset(
                                            "assets/history/settings.png",
                                            width: 32,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            bool? result =
                                                await showConfirmationDialog(
                                              context,
                                              "Apakah Anda yakin ingin menghapus?",
                                            );

                                            if (result != null && result) {
                                              // Call the function to delete reading history
                                              await deleteReadingHistory(
                                                  history.bookId);
                                            }
                                          },
                                          child: Image.asset(
                                            "assets/history/delete.png",
                                            width: 32,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

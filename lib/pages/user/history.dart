import 'package:flutter/material.dart';
import 'package:litracker_mobile/reading_history/models/last_page.dart';

class HistoryBook {
  final String title;
  final String author;
  final int pageNumber;

  HistoryBook({required this.title, required this.author, required this.pageNumber});
}

class HistoryContent extends StatefulWidget {
  const HistoryContent({Key? key}) : super(key: key);

  @override
  State<HistoryContent> createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  List<HistoryBook> historyBooks = [
    HistoryBook(title: 'Buku 1', author: 'Penulis 1', pageNumber: 60),
    HistoryBook(title: 'Buku 2', author: 'Penulis 2', pageNumber: 40),
    // Tambahkan data riwayat bacaan lainnya sesuai kebutuhan
  ];

  Future<bool?> showConfirmationDialog(BuildContext context, String message) async {
    return await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Konfirmasi Hapus',
            style: TextStyle(
              fontFamily: 'SF-Pro',
              fontWeight: FontWeight.w700,
              letterSpacing: -1,
              fontSize: 24,
              color: Color.fromRGBO(8, 4, 22, 1),
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontFamily: 'SF-Pro',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color.fromRGBO(88, 107, 132, 1),
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromRGBO(8, 4, 22, 1),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
              ),
              child: const Text(
                'Batal',
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
                backgroundColor: const Color.fromRGBO(72, 22, 236, 1),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Ya, hapus',
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
  }

  void showSuccessNotification(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Berhasil disimpan"),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Riwayat Bacaan",
                  style: TextStyle(
                    fontFamily: 'SF-Pro',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Text(
                  "Halaman Tersimpan",
                  style: TextStyle(
                    color: Color.fromRGBO(88, 107, 132, 1),
                    fontFamily: 'SF-Pro',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: historyBooks.map((historyBook) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topLeft,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Text(
                          historyBook.pageNumber.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SF-Pro',
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 240,
                        child: const Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                historyBook.title,
                                style: TextStyle(
                                  color: Color.fromRGBO(8, 4, 22, 1),
                                  fontFamily: 'SF-Pro',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                historyBook.author,
                                style: TextStyle(
                                  color: Color.fromRGBO(132, 151, 172, 1),
                                  fontFamily: 'SF-Pro',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
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
                              bool? result = await showDialog<bool?>(
                                context: context,
                                builder: (BuildContext context) {
                                  // ...
                                  // Sama seperti kode sebelumnya untuk atur nomor halaman
                                  // ...
                                },
                              );

                              if (result != null && result) {
                                // Logika simpan
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
                              bool? result = await showConfirmationDialog(
                                context,
                                "Apakah Anda yakin ingin menghapus?",
                              );

                              if (result != null && result) {
                                showSuccessNotification(context);
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
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: HistoryContent(),
      ),
    ),
  );
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistoryContent extends StatefulWidget {
  const HistoryContent({Key? key}) : super(key: key);

  @override
  _HistoryContentState createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  List<dynamic> historyData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final String apiUrl = 'http://reading_history/fetch_history/';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        setState(() {
          historyData = decodedData['history'];
        });
      } else {
        print('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> editPageNumber(int bookId, int newPageNumber) async {
  final String apiUrl = 'http://reading_history/edit_page_number/';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode({
        'bookId': bookId,
        'newPageNumber': newPageNumber,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      showSuccessNotification(context);
      fetchData(); // Mengambil data terbaru setelah edit
    } else {
      print('Failed to edit page number');
    }
  } catch (error) {
    print('Error: $error');
  }
}

Future<void> deleteBook(int bookId) async {
  final String apiUrl = 'http://reading_history/delete_history_entry/';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode({
        'bookId': bookId,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      showSuccessNotification(context);
      fetchData(); // Mengambil data terbaru setelah hapus
    } else {
      print('Failed to delete book');
    }
  } catch (error) {
    print('Error: $error');
  }
}


  void showSuccessNotification(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Berhasil disimpan"),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
              children: historyData.map((entry) {
                return Container(
                  padding: EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(80, 166, 255, 1),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Text(
                          "60",
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
                        child: Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Buku",
                                style: TextStyle(
                                  color: Color.fromRGBO(8, 4, 22, 1),
                                  fontFamily: 'SF-Pro',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Nama Penulis",
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
                                    content: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Color.fromRGBO(
                                                  246, 247, 249, 1),
                                            ),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText: 'Nomor Halaman',
                                                labelStyle: TextStyle(
                                                  fontFamily: 'SF-Pro',
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      132, 151, 172, 1),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        92,
                                                        66,
                                                        255,
                                                        1),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 12),
                                              ),
                                            ),
                                            height: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                              Color.fromRGBO(8, 4, 22, 1),
                                          backgroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
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
                                              Color.fromRGBO(72, 22, 236, 1),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 24,
                                            vertical: 20,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                          showSuccessNotification(context);
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

                              if (result != null && result) {
                                // Panggil fungsi untuk mengatur nomor halaman di backend
                                editPageNumber(
                                    entry['book_id'], int.parse(result.toString()));
                              }
                            },
                            child: Image.asset(
                              "assets/history/settings.png",
                              width: 32,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: () async {
                              // Panggil fungsi untuk menghapus buku di backend
                              deleteBook(entry['book_id']);
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
    MaterialApp(
      home: Scaffold(
        body: HistoryContent(),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:litracker_mobile/reading_history/utils/reading_history_utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:litracker_mobile/reading_history/models/last_page.dart';

class HistoryContent extends StatefulWidget {
  final int bookID;

  const HistoryContent({Key? key, required this.bookID}) : super(key: key);

  @override
  _HistoryContentState createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  Future<Map<String, dynamic>> fetchHistory() async {
    try {
      var url = Uri.parse(
          'http://localhost:8080/reading_history/get_reading_history/${widget.bookID}/');
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        if (data['reading_histories'].isNotEmpty) {
          List<Map<String, dynamic>> historyList = [];
          for (var historyData in data['reading_histories']) {
            historyList.add({
              'id': historyData['id'],
              'username': historyData['username'],
              'last_page': historyData['last_page'],
              'date_opened': historyData['date_opened'],
            });
          }
          return {
            'history': historyList,
            'history_count': data['history_count']
          };
        } else {
          return {'history': <Map<String, dynamic>>[], 'history_count': 0};
        }
      } else {
        throw Exception('Failed to load reading history');
      }
    } catch (e) {
      print(e.toString());
      return {'history': [], 'history_count': 0};
    }
  }

  // Fungsi untuk menghapus riwayat bacaan
  Future<void> deleteReadingHistory(int historyId) async {
    final response = await http.delete(
      Uri.parse(
          'http://localhost:8080/reading_history/delete_reading_history/$historyId/'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete reading history');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

@override
Widget build(BuildContext context) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: fetchHistory(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        final historyList = snapshot.data!;
        return SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(40),
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
                      "Daftar Riwayat Bacaanmu",
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
                  children: [
                    for (var history in historyList)
                      Container(
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Text(
                                history['last_page'].toString(),
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
                                width: MediaQuery.of(context).size.width - 240,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama Buku",
                                      style: const TextStyle(
                                        color: Color.fromRGBO(8, 4, 22, 1),
                                        fontFamily: 'SF-Pro',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Nama Penulis",
                                      style: const TextStyle(
                                        color: Color.fromRGBO(132, 151, 172, 1),
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
                            // ... (Widget lainnya)
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    },
  );
}

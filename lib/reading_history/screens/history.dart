import 'package:flutter/material.dart';
import 'package:litracker_mobile/reading_history/utils/reading_history_utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HistoryContent extends StatefulWidget {
  const HistoryContent({Key? key}) : super(key: key);

  @override
  _HistoryContentState createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  late Future<List<Map<String, dynamic>>> historyData;

  @override
  void initState() {
    super.initState();
    historyData = fetchHistoryData(); // Ganti dengan fungsi yang sesuai
  }

  Future<List<Map<String, dynamic>>> fetchHistoryData() async {
    final response = await http.get(
        Uri.parse('https://localhost:8080/get_all_reading_history/')); // Ganti dengan URL API
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['history'];
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load history data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: historyData,
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
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
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

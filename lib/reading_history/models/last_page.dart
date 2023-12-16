// To parse this JSON data, do
//
//     final HistoryBook = HistoryBookFromJson(jsonString);

import 'dart:convert';

HistoryBook HistoryBookFromJson(String str) => HistoryBook.fromJson(json.decode(str));

String HistoryBookToJson(HistoryBook data) => json.encode(data.toJson());

class HistoryBook {
    List<History> history;

    HistoryBook({
        required this.history,
    });

    factory HistoryBook.fromJson(Map<String, dynamic> json) => HistoryBook(
        history: List<History>.from(json["history"].map((x) => History.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
    };
}

class History {
    int userId;
    int bookId;
    int lastPage;
    DateTime dateOpened;

    History({
        required this.userId,
        required this.bookId,
        required this.lastPage,
        required this.dateOpened,
    });

    factory History.fromJson(Map<String, dynamic> json) => History(
        userId: json["user_id"],
        bookId: json["book_id"],
        lastPage: json["last_page"],
        dateOpened: DateTime.parse(json["date_opened"]),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "book_id": bookId,
        "last_page": lastPage,
        "date_opened": dateOpened.toIso8601String(),
    };
}

// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Model model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String isbn;
  String title;
  String author;
  int publishedYear;
  String publisher;
  String imageUrlS;
  String imageUrlM;
  String imageUrlL;

  Fields({
    required this.isbn,
    required this.title,
    required this.author,
    required this.publishedYear,
    required this.publisher,
    required this.imageUrlS,
    required this.imageUrlM,
    required this.imageUrlL,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isbn: json["isbn"],
        title: json["title"],
        author: json["author"],
        publishedYear: json["published_year"],
        publisher: json["publisher"],
        imageUrlS: json["image_url_s"],
        imageUrlM: json["image_url_m"],
        imageUrlL: json["image_url_l"],
      );
  Map<String, dynamic> toJson() => {
        "isbn": isbn,
        "title": title,
        "author": author,
        "published_year": publishedYear,
        "publisher": publisher,
        "image_url_s": imageUrlS,
        "image_url_m": imageUrlM,
        "image_url_l": imageUrlL,
      };
}

enum Model { bookBook }

final modelValues = EnumValues({"book.book": Model.bookBook});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

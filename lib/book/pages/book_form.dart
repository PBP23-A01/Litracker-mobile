// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:litracker_mobile/pages/admin/admin_home.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookFormPage extends StatefulWidget {
  const BookFormPage({super.key});

  @override
  State<BookFormPage> createState() => _BookFormPageState();
}

class _BookFormPageState extends State<BookFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _isbn = "";
  String _title = "";
  String _author = "";
  int _publishedYear = 0;
  String _publisher = "";
  String _image_url_s = "";
  String _image_url_m = "";
  String _image_url_l = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Form Add Book',
            ),
          ),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  // ISBN
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "ISBN",
                      labelText: "ISBN",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _isbn = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "ISBN tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Title
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Judul Buku",
                      labelText: "Judul Buku",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _title = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Judul buku tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Author
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Penulis",
                      labelText: "Penulis",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _author = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Nama penulis tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Tahun buku dirilis",
                      labelText: "Tahun buku dirilis",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _publishedYear = int.parse(value!);
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Tahun buku dirilis tidak boleh kosong!";
                      }
                      if (int.tryParse(value) == null) {
                        return "Tahun buku dirilis harus berupa angka!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Publisher
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Penulis",
                      labelText: "Penulis",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _publisher = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Publisher buku tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Image URL L
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Cover Buku (isi dengan link image)",
                      labelText: "Cover Buku",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _image_url_l = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Cover buku tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Send to Django and wait for response
                          final response = await request.postJson(
                              "http://localhost:8080/home/add-book-mobile/",
                              jsonEncode(<String, String>{
                                'isbn': _isbn,
                                'title': _title,
                                'author': _author,
                                'published_year': _publishedYear.toString(),
                                'publisher': _publisher,
                                'image_url_s': _image_url_s,
                                'image_url_m': _image_url_m,
                                'image_url_l': _image_url_l,
                              }));
                          if (response['status'] == 'success') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AdminHome()),
                            );
                            showDialogWithText(
                                context, "Buku berhasil ditambahkan");
                          } else {
                            showDialogWithText(context,
                                "Terdapat kesalahan silahkan coba lagi!");
                          }
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

void showDialogWithText(BuildContext context, String dialogText) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        dialogText,
        style: const TextStyle(
          fontFamily: 'SF-Pro',
          fontWeight: FontWeight.w700,
          letterSpacing: -1,
          fontSize: 16,
          color: Color.fromRGBO(8, 4, 22, 1),
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
            backgroundColor: const Color.fromRGBO(72, 22, 236, 1),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
          ),
          child: const Text(
            'OK',
            style: TextStyle(
              fontFamily: 'SF-Pro',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

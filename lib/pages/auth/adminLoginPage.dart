// ignore_for_file: file_names, unused_import, use_build_context_synchronously, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:litracker_mobile/pages/admin/admin_home.dart';
import 'package:litracker_mobile/pages/auth/registPage.dart';
import 'package:litracker_mobile/data/models/user.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key});

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool showError =
      false; // Add this variable to track whether to show the error

  void showSuccessNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(
            top: 60,
            right: 40,
            left: 40,
            bottom: 20,
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    "assets/images/left-arrow-login.svg",
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: const TextSpan(
                    text: "Login Administrator",
                    style: TextStyle(
                      color: Color.fromRGBO(8, 4, 22, 1),
                      fontFamily: 'SF-Pro',
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: const TextSpan(
                    text:
                        "Jika Anda bukan admin, Anda bisa kembali ke laman sebelumnya",
                    style: TextStyle(
                      color: Color.fromRGBO(8, 4, 22, 1),
                      fontFamily: 'SF-Pro',
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      height: 20 / 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: _usernameController,
                obscureText: false,
                style: const TextStyle(
                  fontFamily: 'SF-Pro',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(8, 4, 22, 1),
                ),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: const TextStyle(
                    fontFamily: 'SF-Pro',
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color.fromRGBO(8, 4, 22, 1),
                  ),
                  hintText: 'Masukkan username',
                  hintStyle: const TextStyle(
                    fontFamily: 'SF-Pro',
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    color: Color.fromRGBO(132, 151, 172, 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(
                            234, 237, 255, 1)), // Warna saat normal
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(
                            145, 149, 255, 1)), // Warna saat dalam fokus
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  prefixIcon: Image.asset(
                    'assets/images/email.png',
                    width: 32,
                    height: 32,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 56,
                    minHeight: 56,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(
                  fontFamily: 'SF-Pro',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(8, 4, 22, 1),
                ),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    fontFamily: 'SF-Pro',
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color.fromRGBO(8, 4, 22, 1),
                  ),
                  hintText: 'Masukkan password',
                  hintStyle: const TextStyle(
                    fontFamily: 'SF-Pro',
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    color: Color.fromRGBO(132, 151, 172, 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(
                            234, 237, 255, 1)), // Warna saat normal
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(
                            145, 149, 255, 1)), // Warna saat dalam fokus
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  prefixIcon: Image.asset(
                    'assets/images/password.png',
                    width: 32,
                    height: 32,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 56,
                    minHeight: 56,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  try {
                    setState(() {
                      isLoading = true;
                    });

                    final response = await request
                        .login("http://localhost:8080/admin-login/", {
                      'username': username,
                      'password': password,
                    });

                    if (request.loggedIn) {
                      //String message = response['message'];
                      String uname = response['username'];
                      int id = response['id'];
                      loggedInAdmin = Admin(username: uname, id: id);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminHome()),
                      );

                      // Hide the loading indicator
                      setState(() {
                        isLoading = false;
                      });

                      // Show modal
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            'Login Berhasil',
                            style: TextStyle(
                              fontFamily: 'SF-Pro',
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1,
                              fontSize: 24,
                              color: Color.fromRGBO(8, 4, 22, 1),
                            ),
                          ),
                          content: Text(
                            'Selamat datang kembali, $uname!',
                            style: const TextStyle(
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
                                backgroundColor:
                                    const Color.fromRGBO(72, 22, 236, 1),
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
                    } else {
                      String message = response != null
                          ? response['message']
                          : 'Login failed';

                      // Hide the loading indicator
                      setState(() {
                        isLoading = false;
                      });

                      // Show error and trigger the error border
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(content: Text("$message")));
                      setState(() {
                        showError = true;
                      });
                    }
                  } catch (e) {
                    // Hide the loading indicator
                    setState(() {
                      isLoading = false;
                    });

                    // Show error and trigger the error border
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                          SnackBar(content: Text("An error occurred: $e")));
                    setState(() {
                      showError = true;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  backgroundColor: const Color.fromRGBO(8, 4, 22, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: Size(MediaQuery.of(context).size.width,
                      0), // Set minimumSize ke lebar layar
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Masuk Akun',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

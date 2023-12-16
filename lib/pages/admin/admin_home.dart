// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:litracker_mobile/book/pages/book_form.dart';
import 'package:litracker_mobile/pages/auth/loginPage.dart';
import 'package:litracker_mobile/pages/user/utils/color_choice.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: jaguar400, // Set the background color to jaguar400
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Admin Homepage",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                height:
                    40), // Add some space between the header and the buttons
            buildButton(
              context,
              "Tambah Buku",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookFormPage(),
                  ),
                );
              },
              color: Colors.white,
              textColor: Colors.black,
            ),
            const SizedBox(height: 20), // Add some space between the buttons
            buildButton(
              context,
              "Logout",
              () async {
                final response = await request
                    .logout("http://localhost:8080/logout-mobile/");
                String message = response["message"];
                if (response['status']) {
                  String uname = response["username"];
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message Sampai jumpa, $uname."),
                  ));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message"),
                  ));
                }
              },
              image: Image.asset('assets/profile/profile-logout.png'),
              color: Colors.white,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
    BuildContext context,
    String text,
    VoidCallback onPressed, {
    Widget? image,
    Color color = Colors.blue,
    Color textColor = Colors.white,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null) ...[
              image,
            ],
            const SizedBox(width: 6),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SF-Pro',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

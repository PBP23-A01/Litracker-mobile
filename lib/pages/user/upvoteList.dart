import 'package:flutter/material.dart';

class UpVoteList extends StatefulWidget {
  const UpVoteList({Key? key}) : super(key: key);

  @override
  _UpVoteListState createState() => _UpVoteListState();
}

class _UpVoteListState extends State<UpVoteList> {
  bool isLoading = false;

  void showSuccessNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Berhasil membatalkan upvote!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 247, 249, 1),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Image.asset(
                        "assets/upvote/left-arrow.png",
                        width: 36,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Buku Terupvote",
                    style: TextStyle(
                      fontFamily: 'SF-Pro',
                      letterSpacing: -0.7,
                      color: Color.fromRGBO(
                        8,
                        4,
                        22,
                        1,
                      ),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/upvote/dummy-book.png",
                          width: 52,
                          height: 64,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 220,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nature Kingdom",
                                style: TextStyle(
                                  fontFamily: 'SF-Pro',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Color.fromRGBO(8, 4, 22, 1),
                                  letterSpacing: -0.7,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Clove Griffith",
                                style: TextStyle(
                                  fontFamily: 'SF-Pro',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color.fromRGBO(132, 151, 172, 1),
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(246, 247, 249, 1),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Image.asset("assets/upvote/upvote-36.png"),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "1604",
                                  style: TextStyle(
                                    fontFamily: 'SF-Pro',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Color.fromRGBO(8, 4, 22, 1),
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    'Yakin ingin membatalkan upvote?',
                                    style: TextStyle(
                                      fontFamily: 'SF-Pro',
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -1,
                                      fontSize: 24,
                                      color: Color.fromRGBO(8, 4, 22, 1),
                                    ),
                                  ),
                                  content: Text(
                                    'Tekan OK untuk melanjutkan',
                                    style: TextStyle(
                                      fontFamily: 'SF-Pro',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Color.fromRGBO(88, 107, 132, 1),
                                    ),
                                  ),
                                  backgroundColor: Colors.white,
                                  buttonPadding: EdgeInsets.all(16),
                                  contentPadding: EdgeInsets.only(
                                    bottom: 40,
                                    left: 24,
                                    top: 12,
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
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            Color.fromRGBO(72, 22, 236, 1),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 20,
                                        ),
                                      ),
                                      child: isLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : const Text('OK'),
                                      onPressed: () async {
                                        Navigator.pop(context);

                                        setState(() {
                                          isLoading = true;
                                        });

                                        // Simulate loading
                                        await Future.delayed(
                                          Duration(seconds: 2),
                                        );

                                        setState(() {
                                          isLoading = false;
                                        });

                                        // Show success notification
                                        showSuccessNotification();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isLoading
                                    ? Colors.grey
                                    : Color.fromRGBO(81, 33, 255, 1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              height: 36,
                              width: 88,
                              alignment: Alignment.center,
                              child: isLoading
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 4,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Batalkan",
                                      style: TextStyle(
                                        fontFamily: 'SF-Pro',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

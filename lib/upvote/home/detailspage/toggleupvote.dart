import 'package:flutter/material.dart';
import 'package:litracker_mobile/upvote/home/detailspage/fetch/fetchisupvote.dart';

toggleUpvote(context, bookID, isVoted) {
  return Container(
    child: FutureBuilder<bool>(
      future: fetchHasUserUpvoted(context, bookID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Image.asset(
            isVoted ? "assets/home/upvote_fill.png" : "assets/home/upvote_blank.png",
            width: 36,
            height: 36,
          );
        }
      },
    ),
  );
}

// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

Future<bool> fetchHasUserWishlisted(context, bookID) async {
  final requestTotalUsers = Provider.of<CookieRequest>(context, listen: false);
  final responseUsersWishlist = await requestTotalUsers.get(
      'http://localhost:8080/favorite_book/get_wishlisting_users/${bookID}');

  return responseUsersWishlist['isWishlist'];
}

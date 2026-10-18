import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kpk/src/helpers/constants.dart';
import 'package:kpk/src/models/comment.dart';

class CommentsProvider {
  static Future<CommentsResult> getByPost(Map<String, dynamic> map) async {
    try {
      String url = kApiEndPoints['comment_by_post'] ?? kApiUrl;
      final response = await http.Client().post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(map),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        return CommentsResult(
          parsed.map<Comment>((json) => Comment.fromJson(json)).toList(),
          '',
        );
      } else {
        return CommentsResult([], response.body);
      }
    } catch (e) {
      return CommentsResult([], '$e');
    }
  }
}

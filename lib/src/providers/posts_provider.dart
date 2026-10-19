import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kpk/src/helpers/constants.dart';
import 'package:kpk/src/models/post.dart';

class PostsProvider {
  static Future<PostResult> getLatest(Map<String, dynamic> post) async {
    try {
      String url = kApiEndPoints['latest_post'] ?? kApiUrl;
      final response = await http.Client().post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(post),
      );
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        return PostResult(
          parsed.map<Post>((json) => Post.fromJson(json)).toList(),
          0,
          '',
        );
      } else {
        return PostResult([], 0, response.body);
      }
    } catch (e) {
      return PostResult([], 0, '$e');
    }
  }

  static Future<PostResult> getById(Map<String, dynamic> post) async {
    try {
      String url = kApiEndPoints['post_by_id'] ?? kApiUrl;
      final response = await http.Client().post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(post),
      );
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        return PostResult(
          parsed.map<Post>((json) => Post.fromJson(json)).toList(),
          0,
          '',
        );
      } else {
        return PostResult([], 0, response.body);
      }
    } catch (e) {
      return PostResult([], 0, '$e');
    }
  }

  static Future<PostResult> getByCategory(Map<String, dynamic> map) async {
    try {
      String url = kApiEndPoints['post_by_category'] ?? kApiUrl;
      final response = await http.Client().post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(map),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        return PostResult(
          parsed['posts'].map<Post>((json) => Post.fromJson(json)).toList(),
          parsed['records'],
          '',
        );
      } else {
        return PostResult([], 0, response.body);
      }
    } catch (e) {
      return PostResult([], 0, '$e');
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kpk/src/helpers/constants.dart';
import 'package:kpk/src/models/category.dart';

class CategoriesProvider {
  static Future<CategoriesResult> get(Map map) async {
    try {
      String url = kApiEndPoints['categories_list'] ?? kApiUrl;
      final response = await http.Client().post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        return CategoriesResult(
          parsed.map<Category>((json) => Category.fromJson(json)).toList(),
          '',
        );
      } else {
        return CategoriesResult([], response.body);
      }
    } catch (e) {
      return CategoriesResult([], '$e');
    }
  }
}

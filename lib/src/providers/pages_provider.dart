import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kpk/src/helpers/constants.dart';
import 'package:kpk/src/models/page.dart';

class PagesProvider {
  static Future<PageLinkResult> getPageLinks() async {
    try {
      String url = kApiEndPoints['page_links'] ?? kApiUrl;
      final response = await http.Client().post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: '',
      );
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        return PageLinkResult(
          parsed.map<PageLink>((json) => PageLink.fromJson(json)).toList(),
          '',
        );
      } else {
        return PageLinkResult([], response.body);
      }
    } catch (e) {
      return PageLinkResult([], '$e');
    }
  }
}

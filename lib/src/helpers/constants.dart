import 'package:material_ui/material_ui.dart';

const kAppName = 'Keralappenkavikal';

const kPageSize = 15;
const kMobileBreakpoint = 600.0;
const kMaxContentWidth = 1024.0;

const kBaseUrl = "http://192.168.220.52:3010";
const kApiUrl = "$kBaseUrl/api";
const kImageUrl = "$kBaseUrl/uploads";

const kApiEndPoints = {
  'latest_post': '$kApiUrl/posts/get_latest_posts',
  'post_by_id': '$kApiUrl/posts/get_post_by_id',
  'post_by_category': '$kApiUrl/posts/get_by_category',
  'page_links': '$kApiUrl/pages/get_page_links',
  'page_content': '$kApiUrl/pages/get_page_content',
  'comment_by_post': '$kApiUrl/comments/get_by_post',
  'categories_list': '$kApiUrl/catagories/get',
};

const kPaddingMedium = EdgeInsets.all(8.0);
const kPaddingLarge = EdgeInsets.all(16.0);

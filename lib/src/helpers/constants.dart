import 'package:flutter/material.dart';

const kAppName = 'Keralappenkavikal';

const kPageSize = 15;
const kMobileBreakpoint = 600.0;
const kMaxWidth = 800.0;

const kBaseUrl = "http://192.168.29.8:3005";
const kApiUrl = "$kBaseUrl/api";
const kImageUrl = "$kBaseUrl/uploads";

const kApiEndPoints = {
  'latest_post': '$kApiUrl/get_latest_posts',
  'page_links': '$kApiUrl/get_page_links',
};

const kPaddingMedium = EdgeInsets.all(8.0);
const kPaddingLarge = EdgeInsets.all(16.0);

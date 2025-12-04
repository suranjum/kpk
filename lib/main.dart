import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpk/src/helpers/constants.dart';
import 'package:kpk/src/helpers/globals.dart' as globals;
import 'package:kpk/src/pages/content_page.dart';
import 'package:kpk/src/pages/home_page.dart';
import 'package:kpk/src/pages/post_page.dart';
import 'package:kpk/src/providers/pages_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await loadPageLinks();
  runApp(MyApp());
}

Future<void> loadPageLinks() async {
  final result = await PagesProvider.getPageLinks();
  if (result.error.isEmpty) {
    globals.pageLinks = result.pageLinks;
  } else {
    debugPrint(result.error);
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', name: 'home', builder: (context, state) => HomePage()),
      GoRoute(
        path: '/page/:slug',
        builder: (context, state) {
          final urlSlug = state.pathParameters['slug'];
          return ContentPage(urlSlug: urlSlug ?? '');
        },
      ),
      GoRoute(
        path: '/post/:id',
        builder: (context, state) {
          final postId = state.pathParameters['id'];
          return PostPage(postId: postId ?? '');
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: kAppName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent,),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

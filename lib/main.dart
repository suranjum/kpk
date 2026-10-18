import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:hornbill/hornbill.dart';
import 'package:kpk/src/helpers/constants.dart';
import 'package:kpk/src/helpers/globals.dart' as globals;
import 'package:kpk/src/pages/content_page.dart';
import 'package:kpk/src/pages/home_page.dart';
import 'package:kpk/src/pages/post_page.dart';
import 'package:kpk/src/providers/pages_provider.dart';
import 'package:material_ui/material_ui.dart';

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
      themeMode: ThemeMode.light,
      theme: HTheme(colourScheme: HColourScheme.pink).lightTheme(),
      darkTheme: HTheme(colourScheme: HColourScheme.pink).darkTheme(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

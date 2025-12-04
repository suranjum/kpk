import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kpk/src/helpers/constants.dart';
import 'package:kpk/src/helpers/globals.dart' as globals;
import 'package:kpk/src/models/page.dart';

class KpkAppBar extends StatefulWidget implements PreferredSizeWidget {
  const KpkAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<KpkAppBar> createState() => _KpkAppBarState();
}

class _KpkAppBarState extends State<KpkAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < kMobileBreakpoint;

        return AppBar(
          centerTitle: false,
          title: Row(
            spacing: 4,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('res/kpk-logo.jpg', width: 40, height: 40),
              ),
              Expanded(child: const Text(kAppName)),
            ],
          ),
          actions: isMobile
              ? [
                  PopupMenuButton<PageLink>(
                    onSelected: (value) {
                      context.go('/page/${value.slug}');
                    },
                    itemBuilder: (context) => <PopupMenuEntry<PageLink>>[
                      ...globals.pageLinks.map((link) {
                        return PopupMenuItem<PageLink>(
                          value: link,
                          child: Text(link.title),
                        );
                      }),
                    ],
                    icon: Icon(Icons.menu),
                  ),
                ]
              : [
                  Row(
                    children: [
                      if (constraints.maxWidth > 800)
                        TextButton(
                          onPressed: () {
                            context.go('/');
                          },
                          child: Text('Home'),
                        ),
                      ...globals.pageLinks.map((link) {
                        return TextButton(
                          onPressed: () {
                            context.go('/page/${link.slug}');
                          },
                          child: Text(link.title),
                        );
                      }),
                      SizedBox(width: 10),
                    ],
                  ),
                ],
        );
      },
    );
  }
}

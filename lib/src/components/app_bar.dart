import 'package:go_router/go_router.dart';
import 'package:hornbill/hornbill.dart';
import 'package:kpk/src/helpers/constants.dart';
import 'package:kpk/src/helpers/globals.dart' as globals;
import 'package:material_ui/material_ui.dart';

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
                child: Image.asset('res/kpk-logo.png', width: 40, height: 40),
              ),
              Expanded(child: const Text(kAppName)),
            ],
          ),
          actions: [
            if (isMobile)
              HButton(
                variant: .light,
                color: .primary,
                onPressed: () {
                  context.go('/');
                },
                icon: Icons.home_outlined,
              ),
            if (isMobile)
              HButton(
                variant: .light,
                color: .primary,
                onPressed: _openMenuDialog,
                icon: Icons.menu,
              ),
            if (!isMobile)
              Row(
                children: [
                  if (constraints.maxWidth > 800)
                    HButton(
                      variant: .light,
                      color: .primary,
                      onPressed: () {
                        context.go('/');
                      },
                      label: Text('Home'),
                    ),
                  ...globals.pageLinks.map((link) {
                    return HButton(
                      variant: .light,
                      color: .primary,
                      onPressed: () {
                        context.go('/page/${link.slug}');
                      },
                      label: Text(link.title),
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

  void _openMenuDialog() {
    showHDialog(
      context,
      builder: (context) => HDialog(
        content: globals.pageLinks.map((link) {
          return HButton(
            variant: .light,
            color: .primary,
            onPressed: () {
              context.go('/page/${link.slug}');
            },
            label: Text(link.title),
          );
        }).toList(),
      ),
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hornbill/hornbill.dart';
import 'package:kpk/src/helpers/globals.dart' as globals;

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = globals.categories;

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        Text(
          'Categories',
          textAlign: .center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        HListView.builder(
          itemCount: categories.length,
          itemBuilder: (index) {
            final cg = categories[index];
            return HListTile(
              title: Text(cg.name),
              onTap: () => context.go('/'),
            );
          },
        ),
      ],
    );
  }
}

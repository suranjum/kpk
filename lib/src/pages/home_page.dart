import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kpk/src/components/app_bar.dart';
import 'package:kpk/src/components/post_card.dart';
import 'package:kpk/src/helpers/constants.dart';
import 'package:kpk/src/models/post.dart';
import 'package:kpk/src/providers/posts_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];

  Future<void> getLatestPost() async {
    Map<String, dynamic> post = {'page_size': kPageSize};
    final result = await PostsProvider.getLatest(post);
    if (result.error.isEmpty) {
      setState(() {
        posts = result.posts;
      });
    } else {
      debugPrint(result.error);
    }
  }

  @override
  void initState() {
    super.initState();
    getLatestPost();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > kMobileBreakpoint;

        Widget postGrid = GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isDesktop ? 3 : 1,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 2 / 3,
          children: posts
              .map(
                (post) => InkWell(
                  onTap: () => context.go('/post/${post.id}'),
                  child: PostCard(post: post),
                ),
              )
              .toList(),
        );
        Widget categoryList = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        );

        return Scaffold(
          appBar: KpkAppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: kMaxWidth),
                child: isDesktop
                    ? Row(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2, child: postGrid),
                          Expanded(flex: 1, child: categoryList),
                        ],
                      )
                    : Column(spacing: 16, children: [postGrid, categoryList]),
              ),
            ),
          ),
        );
      },
    );
  }
}

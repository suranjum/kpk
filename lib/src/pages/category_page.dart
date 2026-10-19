import 'package:go_router/go_router.dart';
import 'package:hornbill/hornbill.dart';
import 'package:kpk/src/components/app_bar.dart';
import 'package:kpk/src/components/categories_list.dart';
import 'package:kpk/src/helpers/constants.dart';
import 'package:kpk/src/helpers/date_helper.dart';
import 'package:kpk/src/models/post.dart';
import 'package:kpk/src/providers/posts_provider.dart';
import 'package:material_ui/material_ui.dart';

class CategoryPage extends StatefulWidget {
  final String categoryId;
  const CategoryPage({super.key, required this.categoryId});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Post> posts = [];
  bool isLoading = true;
  int page = 0;
  int totalRecords = 0;
  String error = '';
  int _requestId = 0;

  Future<void> fetchPosts() async {
    final requestId = ++_requestId;
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> map = {
      'cg_id': widget.categoryId,
      'page': page,
      'page_size': kPageSize,
    };
    final res = await PostsProvider.getByCategory(map);
    if (!mounted || requestId != _requestId) return;
    setState(() {
      posts = res.posts;
      error = res.error;
      isLoading = false;
      totalRecords = res.records;
    });
  }

  @override
  void didUpdateWidget(CategoryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      page = 0;
      fetchPosts();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KpkAppBar(),
      body: error.isNotEmpty
          ? Center(child: Text(error))
          : (isLoading
                ? Center(
                    child: SizedBox(width: 100, child: HProgressIndicator()),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: .start,
                        spacing: 8.0,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: .stretch,
                              children: [
                                if (posts.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      posts[0].categoryName,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: .bold,
                                      ),
                                    ),
                                  ),
                                HListView.builder(
                                  itemCount: posts.length,
                                  itemBuilder: (index) {
                                    final post = posts[index];
                                    return HListTile(
                                      title: Text(post.title),
                                      subtitle: Text(
                                        '${post.authorName} | ${formatDateStringDDMMMYYYY(post.modified)}',
                                      ),
                                      onTap: () {
                                        context.go('/post/${post.id}');
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          HPageNavigation(
                            pageNr: page,
                            totalPages: (totalRecords / kPageSize).ceil(),
                            totalRecords: totalRecords,
                            onPrevious: () {
                              if (page != 0) {
                                page--;
                                fetchPosts();
                              }
                            },
                            onNext: () {
                              if (page <
                                  (totalRecords / kPageSize).ceil() - 1) {
                                page++;
                                fetchPosts();
                              }
                            },
                            onPageSelected: (value) {
                              page = value;
                              fetchPosts();
                            },
                          ),
                          Expanded(flex: 1, child: CategoriesList()),
                        ],
                      ),
                    ),
                  )),
    );
  }
}

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hornbill/hornbill.dart';
import 'package:kpk/src/components/app_bar.dart';
import 'package:kpk/src/helpers/constants.dart';
import 'package:kpk/src/helpers/date_helper.dart';
import 'package:kpk/src/models/comment.dart';
import 'package:kpk/src/models/post.dart';
import 'package:kpk/src/providers/comments_provider.dart';
import 'package:kpk/src/providers/posts_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class PostPage extends StatefulWidget {
  final String postId;
  const PostPage({super.key, required this.postId});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Post? post;
  String error = "";
  List<Comment> comments = [];

  Future<void> fetchById() async {
    final Map<String, dynamic> map = {'post_id': widget.postId};
    final res = await PostsProvider.getById(map);
    if (res.error.isEmpty) {
      if (res.posts.isNotEmpty) {
        setState(() {
          post = res.posts[0];
        });
      } else {}
    } else {
      setState(() {
        error = res.error;
      });
    }
  }

  Future<void> fetchComments() async {
    final Map<String, dynamic> map = {'post_id': widget.postId};
    final res = await CommentsProvider.getByPost(map);
    if (res.error.isEmpty) {
      setState(() {
        comments = res.comments;
      });
    } else {
      if (mounted) {
        HToast.show(context, title: res.error, type: .error);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchById();
    fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KpkAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: kMaxWidth),
            child: error.isNotEmpty
                ? Center(child: Text(error))
                : (post == null || post!.id.isEmpty
                      ? Text('Unable to fetch post!')
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: .stretch,
                            spacing: 16,
                            children: [
                              HListItemData(
                                title: Text(
                                  post!.title,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: .bold,
                                  ),
                                ),
                                subtitle: Text(
                                  '${post!.categoryName} | ${formatDateStringDDMMMYYYY(post!.modified)}',
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  final imageUrl =
                                      '$kImageUrl/${post!.featureImage}';
                                  showHDialog(
                                    context,
                                    builder: (dialogContext) {
                                      final size = MediaQuery.sizeOf(
                                        dialogContext,
                                      );
                                      return HDialog(
                                        maxWidth: size.width - 32,
                                        maxHeightFactor: 0.9,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: size.width - 72,
                                            maxHeight: size.height * 0.8,
                                          ),
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: HCard(
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          '$kImageUrl/${post!.featureImage}',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              HtmlWidget(
                                post!.content,
                                onTapUrl: (url) async {
                                  return await launchUrl(Uri.parse(url));
                                },
                              ),
                              Divider(),
                              HListItemData(
                                title: Text('Comments (${comments.length})'),
                              ),
                              ...List.generate(
                                comments.length,
                                (index) => Container(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: context.hColors.border,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: .min,
                                    spacing: 8,
                                    crossAxisAlignment: .stretch,
                                    children: [
                                      HtmlWidget(comments[index].text),
                                      Text(
                                        '${comments[index].userId} | ${formatDateStringDDMMMYYYY(comments[index].date)}',
                                        style: TextStyle(
                                          color:
                                              context.hColors.mutedForeground,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              HTextField(
                                hintText: 'Write your comments here...',
                                maxLines: 5,
                              ),
                              Row(
                                children: [
                                  HButton(
                                    color: .primary,
                                    onPressed: () {},
                                    label: Text('Submit'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
          ),
        ),
      ),
    );
  }
}

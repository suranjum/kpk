import 'package:flutter/material.dart';
import 'package:kpk/src/helpers/constants.dart';
import 'package:kpk/src/helpers/date_helper.dart';
import 'package:kpk/src/models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('$kImageUrl/${post.featureImage}'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(200),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        padding: kPaddingMedium,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Text(
              post.title,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            Row(
              spacing: 4,
              children: [
                Icon(Icons.comment_outlined, size: 12, color: Colors.white),
                Text(
                  '${post.numComments}',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Spacer(),
                Text(
                  formatDateStringDDMMMYYYY(post.modified),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

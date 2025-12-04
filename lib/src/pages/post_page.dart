import 'package:flutter/material.dart';
import 'package:kpk/src/components/app_bar.dart';

class PostPage extends StatefulWidget {
  final String postId;
  const PostPage({super.key, required this.postId});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KpkAppBar(),
      body: Center(child: Text('Read ${widget.postId}')),
    );
  }
}

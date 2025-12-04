class Post {
  String id;
  String title;
  String featureImage;
  int visited;
  String modified;
  String categoryName;
  int numComments;
  String authorName;

  Post(
    this.id,
    this.title,
    this.featureImage,
    this.visited,
    this.modified,
    this.categoryName,
    this.numComments,
    this.authorName,
  );

  Post.fromJson(Map<String, dynamic> json)
    : id = json['post_id'],
      title = json['post_title'],
      featureImage = json['post_feature_img'],
      visited = json['post_visited'],
      modified = json['post_modified'],
      categoryName = json['cg_name'] ?? '',
      numComments = json['ncomments'] ?? 0,
      authorName = json['author_name'] ?? '';
}

class PostResult {
  List<Post> posts;
  int records;
  String error;

  PostResult(this.posts, this.records, this.error);
}

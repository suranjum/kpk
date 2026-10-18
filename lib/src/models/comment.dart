class Comment {
  String id;
  String date;
  String userId;
  bool published;
  String text;

  Comment(this.id, this.date, this.userId, this.published, this.text);

  Comment.fromJson(Map<String, dynamic> json)
    : id = json['cmt_id'],
      date = json['cmt_date'],
      userId = json['cmt_user_id'],
      published = json['cmt_published'] == 1,
      text = json['cmt_text'];
}

class CommentsResult {
  List<Comment> comments;
  String error;

  CommentsResult(this.comments, this.error);
}

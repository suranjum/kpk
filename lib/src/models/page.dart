class PageLink {
  String id;
  String title;
  String slug;

  PageLink(this.id, this.title, this.slug);

  PageLink.fromJson(Map<String, dynamic> json)
    : id = json['page_id'],
      title = json['page_title'],
      slug = json['page_url_slug'];
}

class PageLinkResult {
  List<PageLink> pageLinks;
  String error;

  PageLinkResult(this.pageLinks, this.error);
}

class PageContent {
  String id;
  String title;
  String content;
  String urlSlug;
  String featureImage;
  String authorId;
  String categoryId;
  String modified;

  PageContent(
    this.id,
    this.title,
    this.content,
    this.urlSlug,
    this.featureImage,
    this.authorId,
    this.categoryId,
    this.modified,
  );

  PageContent.fromJson(Map<String, dynamic> json)
    : id = json['page_id'],
      title = json['page_title'],
      content = json['page_content'],
      urlSlug = json['page_url_slug'],
      featureImage = json['page_feat_image'],
      authorId = json['page_author_id'],
      categoryId = json['page_cg_id'],
      modified = json['page_modified'];
}

class PageContentResult {
  List<PageContent> pages;
  String error;

  PageContentResult(this.pages, this.error);
}

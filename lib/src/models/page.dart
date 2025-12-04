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

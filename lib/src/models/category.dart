class Category {
  String id;
  String name;
  String desc;
  int order;
  String modified;

  Category(this.id, this.name, this.desc, this.order, this.modified);

  Category.fromJson(Map<String, dynamic> json)
    : id = json['cg_id'],
      name = json['cg_name'],
      desc = json['cg_desc'],
      order = json['cg_order'],
      modified = json['cg_modified'];
}

class CategoriesResult {
  List<Category> categories;
  String error;

  CategoriesResult(this.categories, this.error);
}

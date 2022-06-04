class EducationCategory {
  int? id;
  String? name;
  String? slug;
  String? createdAt;
  String? updatedAt;

  EducationCategory(
      {this.id, this.name, this.slug, this.createdAt, this.updatedAt});

  EducationCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  static List<EducationCategory> fromJsonList(List data) {
    if (data.isEmpty) return [];
    return data.map((e) => EducationCategory.fromJson(e)).toList();
  }

  @override
  String toString() => name!;
}

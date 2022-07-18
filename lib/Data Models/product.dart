class Product {
  Product({
    required this.id,
    required this.description,
    required this.rating,
    required this.image,
    required this.publishedBy,
  });
  late final int id;
  late final String description;
  late final int rating;
  late final String image;
  late final String publishedBy;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    rating = json['rating'];
    image = json['image'];
    publishedBy = json['published_by'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['description'] = description;
    _data['rating'] = rating;
    _data['image'] = image;
    _data['published_by'] = publishedBy;
    return _data;
  }
}

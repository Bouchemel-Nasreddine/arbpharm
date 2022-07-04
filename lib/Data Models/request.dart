import 'image.dart';

class Request {
  Request({
    required this.id,
    required this.userId,
    required this.requestEstimateId,
    required this.productName,
    required this.amount,
    required this.mark,
    this.price,
    required this.createdAt,
    required this.images,
  });
  late final int id;
  late final int? userId;
  late final int? requestEstimateId;
  late final String productName;
  late final int amount;
  late final String? mark;
  late final int? price;
  late final String? createdAt;
  late final List<Images>? images;
  late final String? image;
  late final String? publishedBy;
  late final int? countOffers;

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    requestEstimateId = json['request_estimate_id'];
    productName = json['product_name'];
    amount = json['amount'];
    mark = json['mark'];
    price = json['price'];
    publishedBy = json['publishedBy'];
    countOffers = json['count_offers'];
    createdAt = json['created_at'];
    image = json['image'];
    if (json['images'] != null) {
      images =
          List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_name'] = productName;
    _data['amount'] = amount;
    _data['mark'] = mark;
    if (_data['price'] != null) _data['price'] = price;
    _data['images'] = images!.map((e) => e.toJson()).toList();
    return _data;
  }
}

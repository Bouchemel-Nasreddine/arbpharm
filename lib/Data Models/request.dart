import 'image.dart';

class Request {
  Request({
    required this.id,
    required this.userId,
    required this.requestEstimateId,
    required this.productName,
    required this.amount,
    required this.mark,
    required this.price,
    required this.createdAt,
    required this.images,
  });
  late final int id;
  late final int userId;
  late final int requestEstimateId;
  late final String productName;
  late final int amount;
  late final String mark;
  late final int? price;
  late final String createdAt;
  late final List<Images> images;

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    requestEstimateId = json['request_estimate_id'];
    productName = json['product_name'];
    amount = json['amount'];
    mark = json['mark'];
    price = json['price'];
    createdAt = json['created_at'];
    images = List.from(json['images']).map((e) => Images.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['request_estimate_id'] = requestEstimateId;
    _data['product_name'] = productName;
    _data['amount'] = amount;
    _data['mark'] = mark;
    _data['price'] = price;
    _data['created_at'] = createdAt;
    _data['images'] = images.map((e) => e.toJson()).toList();
    return _data;
  }
}

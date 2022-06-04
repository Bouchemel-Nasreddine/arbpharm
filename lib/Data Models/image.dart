class Images {
  Images({
    required this.id,
    required this.userOfferId,
    required this.path,
    required this.createdAt,
  });
  late final int id;
  late final int userOfferId;
  late final String path;
  late final String createdAt;

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userOfferId = json['user_offer_id'];
    path = json['path'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_offer_id'] = userOfferId;
    _data['path'] = path;
    _data['created_at'] = createdAt;
    return _data;
  }
}

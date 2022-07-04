import './profile.dart';

class User {
  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.token,
    required this.expiredAt,
    required this.type,
    required this.success,
    required this.isActive,
    required this.profileName,
    required this.dateCreation,
    required this.activation,
    required this.activationDate,
    required this.getProfile,
  });

  User.initialise() {
    connected = false;
  }

  late final int id;
  late final String email;
  late final String phone;
  late final String token;
  late final String? expiredAt;
  late final String? type;
  late final bool success;
  late final bool isActive;
  late final String profileName;
  late final String dateCreation;
  late final String activation;
  late final String activationDate;
  late final Profile getProfile;
  late int? productCount;
  late int? requestCount;
  late bool connected;
  late bool isTypeActivated;

  User.fromLoginInVerification(Map<String, dynamic> json) {
    connected = true;
    isTypeActivated = isTypeActivated;
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    token = json['token'];
    productCount = json['products_count'];
    requestCount = json['requests_count'];
    expiredAt = json['expired_at'];
    type = json['type'];
    if (json.containsKey('success')) success = json['success'];
    isActive = json['is_active'];
    profileName = json['profile_name'];
    dateCreation = json['date_creation'];
    activation = json['activation'];
    activationDate = json['activation_date'];
    getProfile = Profile.fromJson(json['get_profile']);
    connected = true;
    isTypeActivated = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['token'] = token;
    _data['expired_at'] = expiredAt;
    _data['type'] = type;
    _data['success'] = success;
    _data['is_active'] = isActive;
    _data['profile_name'] = profileName;
    _data['date_creation'] = dateCreation;
    _data['activation'] = activation;
    _data['activation_date'] = activationDate;
    _data['get_profile'] = getProfile.toJson();
    return _data;
  }
}

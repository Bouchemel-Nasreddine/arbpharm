class Profile {
  Profile({
    required this.id,
    required this.userId,
    required this.profilePic,
    required this.socialName,
    required this.socialPlace,
    required this.commercialName,
    required this.numRc,
    required this.nif,
    required this.nis,
    required this.numAr,
    required this.activityCode,
    required this.deletedAt,
  });
  late final int id;
  late final int userId;
  late final String? profilePic;
  late final String socialName;
  late final String? socialPlace;
  late final String commercialName;
  late final String numRc;
  late final String nif;
  late final String? nis;
  late final String? numAr;
  late final String activityCode;
  late final String? deletedAt;

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    profilePic = json['profile_pic'];
    socialName = json['social_name'];
    socialPlace = json['social_place'];
    commercialName = json['commercial_name'];
    numRc = json['num_rc'];
    nif = json['nif'];
    nis = json['nis'];
    numAr = json['num_ar'];
    activityCode = json['activity_code'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['profile_pic'] = profilePic;
    _data['social_name'] = socialName;
    _data['social_place'] = socialPlace;
    _data['commercial_name'] = commercialName;
    _data['num_rc'] = numRc;
    _data['nif'] = nif;
    _data['nis'] = nis ?? "";
    _data['num_ar'] = numAr ?? "";
    _data['activity_code'] = activityCode;
    _data['deleted_at'] = deletedAt;
    return _data;
  }
}

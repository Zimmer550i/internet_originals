class SocialPlatformModel {
  String id;
  String followerCount;
  String url;
  String platformName;
  String userId;
  String createdAt;
  String updatedAt;
  int v;

  SocialPlatformModel({
    required this.id,
    required this.followerCount,
    required this.url,
    required this.platformName,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SocialPlatformModel.fromJson(Map<String, dynamic> json) {
    return SocialPlatformModel(
      id: json['_id'],
      followerCount: json['followers'],
      url: json['link'],
      platformName: json['platformName'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'followers': followerCount,
      'link': url,
      'platformName': platformName,
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

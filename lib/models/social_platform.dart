class SocialPlatformModel {
  final String platform;
  final String link;
  final int followers;

  SocialPlatformModel({
    required this.platform,
    required this.link,
    required this.followers,
  });

  /// From JSON
  factory SocialPlatformModel.fromJson(Map<String, dynamic> json) {
    return SocialPlatformModel(
      platform: json['platform'] ?? '',
      link: json['link'] ?? '',
      followers: json['followers'] ?? 0,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'link': link,
      'followers': followers,
    };
  }

  /// Copy with method
  SocialPlatformModel copyWith({
    String? platform,
    String? link,
    int? followers,
  }) {
    return SocialPlatformModel(
      platform: platform ?? this.platform,
      link: link ?? this.link,
      followers: followers ?? this.followers,
    );
  }

  @override
  String toString() {
    return 'SocialPlatformModel(platform: $platform, link: $link, followers: $followers)';
  }
}

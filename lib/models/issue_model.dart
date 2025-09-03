class IssueModel {
  final String id;
  final String content;
  bool unread;
  final String influencerName;
  final num influencerRating;
  final String? influencerAvatar;

  IssueModel({
    required this.id,
    required this.content,
    required this.unread,
    required this.influencerName,
    required this.influencerRating,
    required this.influencerAvatar,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      id: json['id'] as String,
      content: json['content'] as String,
      unread: json['unread'] as bool,
      influencerName: json['influencerName'] as String,
      influencerRating: json['influencerRating'],
      influencerAvatar: json['influencerAvatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'unread': unread,
      'influencerName': influencerName,
      'influencerRating': influencerRating,
      'influencerAvatar': influencerAvatar,
    };
  }
}

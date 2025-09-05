import 'package:internet_originals/models/user_model.dart';

class MatrixModel {
  final String campaignId;
  final String influencerId;
  final UserModel influencer;
  final String status;
  final Map<String, dynamic>? matrix;

  MatrixModel({
    required this.campaignId,
    required this.influencerId,
    required this.influencer,
    required this.status,
    this.matrix,
  });

  factory MatrixModel.fromJson(Map<String, dynamic> json) {
    return MatrixModel(
      campaignId: json['campaignId'] ?? '',
      influencerId: json['influencerId'] ?? '',
      influencer: UserModel.fromJson(json['influencer']),
      status: json['status'] ?? '',
      matrix: json['matrix'], // nullable
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'campaignId': campaignId,
      'influencerId': influencerId,
      'influencer': influencer.toJson(),
      'status': status,
      'matrix': matrix,
    };
  }
}
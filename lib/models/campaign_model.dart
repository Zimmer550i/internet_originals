class CampaignModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final String campaignId;
  final String influencerId;
  final String? influencerAgreementProof;
  final String? postLink;
  final String? screenshot;
  final dynamic matrix;
  final num budget;
  final bool isPaymentDone;
  final bool isTimeout;
  final bool isRevision;
  final String paymentStatus;
  final String title;
  final String description;
  final String brand;
  final String banner;
  final String campaignType;
  final DateTime duration;
  final String contentType;
  final String payoutDeadline;
  final Map<String, dynamic>? expectedMetrics;
  final Map<String, dynamic>? otherFields;
  final num rating;

  CampaignModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.campaignId,
    required this.influencerId,
    this.influencerAgreementProof,
    this.postLink,
    this.screenshot,
    this.matrix,
    required this.budget,
    required this.isPaymentDone,
    required this.isTimeout,
    required this.isRevision,
    required this.paymentStatus,
    required this.title,
    required this.description,
    required this.brand,
    required this.banner,
    required this.campaignType,
    required this.duration,
    required this.contentType,
    required this.payoutDeadline,
    this.expectedMetrics,
    this.otherFields,
    required this.rating,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      status: json['status'] ?? '',
      campaignId: json['campaignId'] ?? '',
      influencerId: json['influencerId'] ?? '',
      influencerAgreementProof: json['influencerAgreementProof'],
      postLink: json['postLink'],
      screenshot: json['screenshot'],
      matrix: json['matrix'],
      budget: json['budget'] ?? 0,
      isPaymentDone: json['isPaymentDone'] ?? false,
      isTimeout: json['isTimeout'] ?? false,
      isRevision: json['isRevision'] ?? false,
      paymentStatus: json['paymentStatus'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      brand: json['brand'] ?? '',
      banner: json['banner'] ?? '',
      campaignType: json['campaign_type'] ?? '',
      duration: DateTime.parse(json['duration']),
      contentType: json['content_type'] ?? '',
      payoutDeadline: json['payout_deadline'] ?? '',
      expectedMetrics: json['expected_metrics'],
      otherFields: json['other_fields'],
      rating: json['rating'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status,
      'campaignId': campaignId,
      'influencerId': influencerId,
      'influencerAgreementProof': influencerAgreementProof,
      'postLink': postLink,
      'screenshot': screenshot,
      'matrix': matrix,
      'budget': budget,
      'isPaymentDone': isPaymentDone,
      'isTimeout': isTimeout,
      'isRevision': isRevision,
      'paymentStatus': paymentStatus,
      'title': title,
      'description': description,
      'brand': brand,
      'banner': banner,
      'campaign_type': campaignType,
      'duration': duration.toIso8601String(),
      'content_type': contentType,
      'payout_deadline': payoutDeadline,
      'expected_metrics': expectedMetrics,
      'other_fields': otherFields,
      'rating': rating,
    };
  }
}

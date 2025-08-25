// ignore_for_file: constant_identifier_names

enum CampaignStatus {
  PENDING,
  ACTIVE,
  COMPLETED,
}

enum PaymentStatus {
  PENDING,
  PAID,
  FAILED,
}

class CampaignModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String description;
  final String brand;
  final String banner;
  final String campaignType;
  final int budget;
  final DateTime duration;
  final String contentType;
  final String payoutDeadline; 
  final Map<String, dynamic>? expectedMetrics;
  final Map<String, dynamic>? otherFields;
  final int rating;
  final CampaignStatus status;
  final PaymentStatus paymentStatus;

  CampaignModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.description,
    required this.brand,
    required this.banner,
    required this.campaignType,
    required this.budget,
    required this.duration,
    required this.contentType,
    required this.payoutDeadline, // <-- String
    this.expectedMetrics,
    this.otherFields,
    required this.rating,
    required this.status,
    required this.paymentStatus,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      title: json['title'] as String,
      description: json['description'] as String,
      brand: json['brand'] as String,
      banner: json['banner'] as String,
      campaignType: json['campaign_type'] as String,
      budget: json['budget'] as int,
      duration: DateTime.parse(json['duration'] as String),
      contentType: json['content_type'] as String,
      payoutDeadline: json['payout_deadline'] as String,
      expectedMetrics: json['expected_metrics'] != null
          ? Map<String, dynamic>.from(json['expected_metrics'])
          : null,
      otherFields: json['other_fields'] != null
          ? Map<String, dynamic>.from(json['other_fields'])
          : null,
      rating: json['rating'] as int,
      status: CampaignStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => CampaignStatus.PENDING,
      ),
      paymentStatus: PaymentStatus.values.firstWhere(
        (e) => e.name == json['paymentStatus'],
        orElse: () => PaymentStatus.PENDING,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'title': title,
      'description': description,
      'brand': brand,
      'banner': banner,
      'campaign_type': campaignType,
      'budget': budget,
      'duration': duration.toIso8601String(),
      'content_type': contentType,
      'payout_deadline': payoutDeadline, 
      'expected_metrics': expectedMetrics,
      'other_fields': otherFields,
      'rating': rating,
      'status': status.name,
      'paymentStatus': paymentStatus.name,
    };
  }
}

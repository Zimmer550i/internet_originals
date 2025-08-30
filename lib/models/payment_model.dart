class PaymentModel {
  final String id;
  final String influencerName;
  final double influencerRating;
  final String influencerAvatar;
  final String campaignName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? taskId;
  final String? influencerId;
  final num amount;
  final String method;
  final List<String> invoices;
  final String status;
  final Map<String, Metric>? matrix; // Optional nested stats
  final String? postLink;
  final String? screenshot;

  PaymentModel({
    required this.id,
    required this.influencerName,
    required this.influencerRating,
    required this.influencerAvatar,
    required this.campaignName,
    required this.createdAt,
    required this.updatedAt,
    this.taskId,
    this.influencerId,
    required this.amount,
    required this.method,
    required this.invoices,
    required this.status,
    this.matrix,
    this.postLink,
    this.screenshot,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] ?? '',
      influencerName: json['influencerName'] ?? '',
      influencerRating: (json['influencerRating'] ?? 0).toDouble(),
      influencerAvatar: json['influencerAvatar'] ?? '',
      campaignName: json['campaignName'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      taskId: json['taskId'], // may not exist
      influencerId: json['influencerId'], // may not exist
      amount: json['amount'] ?? 0,
      method: json['method'] ?? '',
      invoices: List<String>.from(json['invoices'] ?? []),
      status: json['status'] ?? '',
      matrix: json['matrix'] != null
          ? (json['matrix'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                key,
                Metric.fromJson(value),
              ),
            )
          : null,
      postLink: json['postLink'],
      screenshot: json['screenshot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'influencerName': influencerName,
      'influencerRating': influencerRating,
      'influencerAvatar': influencerAvatar,
      'campaignName': campaignName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      if (taskId != null) 'taskId': taskId,
      if (influencerId != null) 'influencerId': influencerId,
      'amount': amount,
      'method': method,
      'invoices': invoices,
      'status': status,
      if (matrix != null)
        'matrix': matrix!.map((key, value) => MapEntry(key, value.toJson())),
      if (postLink != null) 'postLink': postLink,
      if (screenshot != null) 'screenshot': screenshot,
    };
  }
}

class Metric {
  final num value;
  final String goal;

  Metric({
    required this.value,
    required this.goal,
  });

  factory Metric.fromJson(Map<String, dynamic> json) {
    return Metric(
      value: json['value'] ?? 0,
      goal: json['goal'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'goal': goal,
    };
  }
}

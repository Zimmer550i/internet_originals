// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:internet_originals/models/campaign_model.dart';

enum PaymentStatus {
  PENDING,
  COMPLETED,
  FAILED,
}

class TaskModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String campaignId;
  final DateTime duration;
  final String influencerId;
  final String? influencerAgreementProof;
  final String? postLink;
  final Map<String, dynamic>? matrix;
  final PaymentStatus paymentStatus;
  final CampaignModel campaign;

  TaskModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.campaignId,
    required this.duration,
    required this.influencerId,
    this.influencerAgreementProof,
    this.postLink,
    this.matrix,
    required this.paymentStatus,
    required this.campaign,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      campaignId: json['campaignId'] as String,
      duration: DateTime.parse(json['duration'] as String),
      influencerId: json['influencerId'] as String,
      influencerAgreementProof: json['influencerAgreementProof'],
      postLink: json['postLink'],
      matrix: json['matrix'] != null
          ? Map<String, dynamic>.from(json['matrix'])
          : null,
      paymentStatus: PaymentStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['paymentStatus'],
        orElse: () => PaymentStatus.PENDING,
      ),
      campaign: CampaignModel.fromJson(json['campaign']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'campaignId': campaignId,
      'duration': duration.toIso8601String(),
      'influencerId': influencerId,
      'influencerAgreementProof': influencerAgreementProof,
      'postLink': postLink,
      'matrix': matrix,
      'paymentStatus': paymentStatus.toString().split('.').last,
      'campaign': campaign.toJson(),
    };
  }

  static List<TaskModel> listFromJson(String str) {
    final data = json.decode(str) as List<dynamic>;
    return data.map((e) => TaskModel.fromJson(e)).toList();
  }
}

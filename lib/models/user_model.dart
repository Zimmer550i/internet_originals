// ignore_for_file: constant_identifier_names

import 'package:internet_originals/models/social_platform.dart';

enum EUserRole {
  GUEST,
  USER,
  INFLUENCER,
  ADMIN,
  SUB_ADMIN,
}

class UserModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? fcmToken;
  final EUserRole role;
  final String name;
  final String email;
  final String phone;
  final String? avatar;
  final String? address;
  final double rating;
  final List<SocialPlatformModel> socials;

  UserModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.fcmToken,
    required this.role,
    required this.name,
    required this.email,
    required this.phone,
    this.avatar,
    this.address,
    required this.rating,
    required this.socials,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      fcmToken: json['fcmToken'],
      role: EUserRole.values.firstWhere(
        (e) => e.name == (json['role'] ?? 'GUEST'),
        orElse: () => EUserRole.GUEST,
      ),
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      address: json['address'],
      rating: (json['rating'] ?? 0).toDouble(),
      socials: (json['socials'] as List<dynamic>? ?? [])
          .map((e) => SocialPlatformModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'fcmToken': fcmToken,
      'role': role.name,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'address': address,
      'rating': rating,
      'socials': socials.map((e) => e.toJson()).toList(),
    };
  }
}

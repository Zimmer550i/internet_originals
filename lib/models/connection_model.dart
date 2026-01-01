class ConnectionModel {
  final String id;
  final String managerId;
  final String influencerId;
  final bool isManagerApproved;
  final bool isInfluencerApproved;
  final bool isConnected;
  final DateTime requestedAt;
  final DateTime? connectedAt;
  final String? avatar;
  final String name;
  final int activeCampaigns;
  final int completedCampaigns;

  ConnectionModel({
    required this.id,
    required this.managerId,
    required this.influencerId,
    required this.isManagerApproved,
    required this.isInfluencerApproved,
    required this.isConnected,
    required this.requestedAt,
    required this.connectedAt,
    this.avatar,
    required this.name,
    required this.activeCampaigns,
    required this.completedCampaigns,
  });

  factory ConnectionModel.fromJson(Map<String, dynamic> json) {
    return ConnectionModel(
      id: json['id'] as String,
      managerId: json['managerId'] as String,
      influencerId: json['influencerId'] as String,
      isManagerApproved: json['isManagerApproved'] as bool,
      isInfluencerApproved: json['isInfluencerApproved'] as bool,
      isConnected: json['isConnected'] as bool,
      requestedAt: DateTime.parse(json['requestedAt'] as String),
      connectedAt: DateTime.tryParse(json['connectedAt'] ?? ""),
      avatar: json['avatar'] as String?,
      name: json['name'] as String,
      activeCampaigns: json['activeCampaigns'] as int,
      completedCampaigns: json['completedCampaigns'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'managerId': managerId,
      'influencerId': influencerId,
      'isManagerApproved': isManagerApproved,
      'isInfluencerApproved': isInfluencerApproved,
      'isConnected': isConnected,
      'requestedAt': requestedAt.toIso8601String(),
      'connectedAt': connectedAt?.toIso8601String(),
      'avatar': avatar,
      'name': name,
      'activeCampaigns': activeCampaigns,
      'completedCampaigns': completedCampaigns,
    };
  }

  ConnectionModel copyWith({
    String? id,
    String? managerId,
    String? influencerId,
    bool? isManagerApproved,
    bool? isInfluencerApproved,
    bool? isConnected,
    DateTime? requestedAt,
    DateTime? connectedAt,
    String? avatar,
    String? name,
    int? activeCampaigns,
    int? completedCampaigns,
  }) {
    return ConnectionModel(
      id: id ?? this.id,
      managerId: managerId ?? this.managerId,
      influencerId: influencerId ?? this.influencerId,
      isManagerApproved: isManagerApproved ?? this.isManagerApproved,
      isInfluencerApproved:
          isInfluencerApproved ?? this.isInfluencerApproved,
      isConnected: isConnected ?? this.isConnected,
      requestedAt: requestedAt ?? this.requestedAt,
      connectedAt: connectedAt ?? this.connectedAt,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      activeCampaigns: activeCampaigns ?? this.activeCampaigns,
      completedCampaigns:
          completedCampaigns ?? this.completedCampaigns,
    );
  }
}
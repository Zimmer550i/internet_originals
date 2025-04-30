import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String id;
    String name;
    String role;
    String email;
    String phone;
    bool verified;
    String status;
    String loginStatus;
    DateTime createdAt;
    DateTime updatedAt;
    String? address;
    String? image;
    String? fcmToken;

    UserModel({
        required this.id,
        required this.name,
        required this.role,
        required this.email,
        required this.phone,
        required this.verified,
        required this.status,
        required this.loginStatus,
        required this.createdAt,
        required this.updatedAt,
        required this.address,
        required this.image,
        required this.fcmToken,
    });

    UserModel copyWith({
        String? id,
        String? name,
        String? role,
        String? email,
        String? phone,
        bool? verified,
        String? status,
        String? loginStatus,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? address,
        String? image,
        String? fcmToken,
    }) => 
        UserModel(
            id: id ?? this.id,
            name: name ?? this.name,
            role: role ?? this.role,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            verified: verified ?? this.verified,
            status: status ?? this.status,
            loginStatus: loginStatus ?? this.loginStatus,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            address: address ?? this.address,
            image: image ?? this.image,
            fcmToken: fcmToken ?? this.fcmToken,
        );

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        phone: json["phone"],
        verified: json["verified"],
        status: json["status"],
        loginStatus: json["loginStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        address: json["address"],
        image: json["image"],
        fcmToken: json["fcmToken"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "role": role,
        "email": email,
        "phone": phone,
        "verified": verified,
        "status": status,
        "loginStatus": loginStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "address": address,
        "image": image,
        "fcmToken": fcmToken,
    };
}

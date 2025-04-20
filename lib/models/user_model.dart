import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String id;
    String name;
    String role;
    String email;
    String phone;
    bool verified;
    String loginStatus;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
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
        required this.loginStatus,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
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
        String? loginStatus,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? v,
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
            loginStatus: loginStatus ?? this.loginStatus,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            v: v ?? this.v,
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
        loginStatus: json["loginStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
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
        "loginStatus": loginStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "address": address,
        "image": image,
        "fcmToken": fcmToken,
    };
}

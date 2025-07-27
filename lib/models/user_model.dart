// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int id;
  final String yierNumber;
  final String password;
  final String name;
  final String? address;
  final String? sex;
  final DateTime? birthday;
  final int? mateId;
  final String? coupleLinkId;
  final String? relationship;
  final String? manifesto;
  final bool manifestConsistentWhether;
  final String? coupleNickname;
  final bool isAdmin;
  final String? avatarUrl;
  final int point;
  final int? coupleRequestRequesterId;
  final int? coupleRequestTargetId;
  final String? coupleRequestStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.yierNumber,
    required this.password,
    required this.name,
    this.address,
    this.sex,
    this.birthday,
    this.mateId,
    this.coupleLinkId,
    this.relationship,
    this.manifesto,
    required this.manifestConsistentWhether,
    this.coupleNickname,
    required this.isAdmin,
    this.avatarUrl,
    required this.point,
    this.coupleRequestRequesterId,
    this.coupleRequestTargetId,
    this.coupleRequestStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    yierNumber: json["yier_number"],
    // 后端出于安全考虑不会返回密码，因此在这里提供一个默认的空字符串
    password: json["password"] ?? "",
    name: json["name"],
    address: json["address"],
    sex: json["sex"],
    birthday: json["birthday"] == null
        ? null
        : DateTime.parse(json["birthday"]),
    mateId: json["mate_id"],
    coupleLinkId: json["couple_link_id"],
    relationship: json["relationship"],
    manifesto: json["manifesto"],
    manifestConsistentWhether: json["manifest_consistent_whether"],
    coupleNickname: json["couple_nickname"],
    isAdmin: json["is_admin"],
    avatarUrl: json["avatar_url"],
    point: json["point"],
    coupleRequestRequesterId: json["coupleRequestRequesterId"],
    coupleRequestTargetId: json["coupleRequestTargetId"],
    coupleRequestStatus: json["coupleRequestStatus"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "yier_number": yierNumber,
    "password": password,
    "name": name,
    "address": address,
    "sex": sex,
    "birthday": birthday == null
        ? null
        : "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
    "mate_id": mateId,
    "couple_link_id": coupleLinkId,
    "relationship": relationship,
    "manifesto": manifesto,
    "manifest_consistent_whether": manifestConsistentWhether,
    "is_admin": isAdmin,
    "avatar_url": avatarUrl,
    "point": point,
    "coupleRequestRequesterId": coupleRequestRequesterId,
    "coupleRequestTargetId": coupleRequestTargetId,
    "coupleRequestStatus": coupleRequestStatus,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

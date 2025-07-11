// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DonorModel {
  final String? authId;
  final String name;
  final String? id;
  final String donorId;
  final int age;
  final String gender;
  final DateTime dob;
  final String bloodGroup;
  final String phone;
  final String email;
  final String address;
  final String city;
  final String state;
  final bool acceptedTerms;
  final String activeStatus;
  final String imageUrl;
  final Timestamp? createdAt;

  DonorModel({
    this.authId,
    required this.name,
    this.id,
    required this.donorId,
    required this.age,
    required this.gender,
    required this.dob,
    required this.bloodGroup,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.acceptedTerms,
    required this.activeStatus,
    required this.imageUrl,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'authId': authId,
      'name': name,
      'id': id,
      'donorId': donorId,
      'age': age,
      'gender': gender,
      'dob': dob.millisecondsSinceEpoch,
      'bloodGroup': bloodGroup,
      'phone': phone,
      'email': email,
      'address': address,
      'city': city,
      'state': state,
      'acceptedTerms': acceptedTerms,
      'activeStatus': activeStatus,
      'imageUrl': imageUrl,
      'createdAt': createdAt ?? Timestamp.now(),
    };
  }

  factory DonorModel.fromMap(Map<String, dynamic> map) {
    try {
      return DonorModel(
        authId: map['authId'] as String?,
        name: map['name'] as String? ?? "Unknown",
        id: map['id'] as String?,
        donorId: map['donorId'] as String? ?? "Unknown",
        age: map['age'] as int? ?? 0,
        gender: map['gender'] as String? ?? "Other",
        dob: map['dob'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['dob'])
            : DateTime(1970),
        bloodGroup: map['bloodGroup'] as String? ?? "Unknown",
        phone: map['phone'] as String? ?? "Unknown",
        email: map['email'] as String? ?? "Unknown",
        address: map['address'] as String? ?? "Unknown",
        city: map['city'] as String? ?? "Unknown",
        state: map['state'] as String? ?? "Unknown",
        acceptedTerms: map['acceptedTerms'] as bool? ?? false,
        activeStatus: map['activeStatus'] as String? ?? "inactive",
        imageUrl: map['imageUrl'] as String? ?? "",
        createdAt: map['createdAt'] != null
            ? map['createdAt'] as Timestamp
            : Timestamp.now(),
      );
    } catch (e) {
      throw Exception("Error parsing DonorModel: $e\nData: $map");
    }
  }

  String toJson() => json.encode(toMap());

  factory DonorModel.fromJson(String source) =>
      DonorModel.fromMap(json.decode(source));
}

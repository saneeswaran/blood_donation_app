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
    return <String, dynamic>{
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
      'createdAt': createdAt,
    };
  }

  factory DonorModel.fromMap(Map<String, dynamic> map) {
    return DonorModel(
      authId: map['authId'] != null ? map['authId'] as String : null,
      name: map['name'] as String,
      id: map['id'] != null ? map['id'] as String : null,
      donorId: map['donorId'] as String,
      age: map['age'] as int,
      gender: map['gender'] as String,
      dob: DateTime.fromMillisecondsSinceEpoch(map['dob'] as int),
      bloodGroup: map['bloodGroup'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      acceptedTerms: map['acceptedTerms'] as bool,
      activeStatus: map['activeStatus'] as String,
      imageUrl: map['imageUrl'] as String,
      createdAt: map['createdAt'] != null
          ? map['createdAt'] as Timestamp
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DonorModel.fromJson(String source) =>
      DonorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DonorModel(authId: $authId, name: $name, id: $id, donorId: $donorId, age: $age, gender: $gender, dob: $dob, bloodGroup: $bloodGroup, phone: $phone, email: $email, address: $address, city: $city, state: $state, acceptedTerms: $acceptedTerms, activeStatus: $activeStatus, imageUrl: $imageUrl, createdAt: $createdAt)';
  }
}

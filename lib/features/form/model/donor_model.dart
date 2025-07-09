// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DonorModel {
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
  final String imageUrl;
  DonorModel({
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
    required this.imageUrl,
  });
  final Timestamp? becomeADonorDate = Timestamp.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
      'imageUrl': imageUrl,
    };
  }

  factory DonorModel.fromMap(Map<String, dynamic> map) {
    return DonorModel(
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
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DonorModel.fromJson(String source) =>
      DonorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

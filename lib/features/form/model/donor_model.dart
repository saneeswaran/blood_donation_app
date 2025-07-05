// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DonorModel {
  final String name;
  final String? id;
  final String bloodType;
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
  final String hasChronicDisease;
  final bool acceptedTerms;
  DonorModel({
    required this.name,
    this.id,
    required this.bloodType,
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
    required this.hasChronicDisease,
    required this.acceptedTerms,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'bloodType': bloodType,
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
      'hasChronicDisease': hasChronicDisease,
      'acceptedTerms': acceptedTerms,
    };
  }

  factory DonorModel.fromMap(Map<String, dynamic> map) {
    return DonorModel(
      name: map['name'] as String,
      id: map['id'] != null ? map['id'] as String : null,
      bloodType: map['bloodType'] as String,
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
      hasChronicDisease: map['hasChronicDisease'] as String,
      acceptedTerms: map['acceptedTerms'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory DonorModel.fromJson(String source) =>
      DonorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

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
  final bool hasChronicDisease;
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

  DonorModel copyWith({
    String? name,
    String? id,
    String? bloodType,
    String? donorId,
    int? age,
    String? gender,
    DateTime? dob,
    String? bloodGroup,
    String? phone,
    String? email,
    String? address,
    String? city,
    String? state,
    bool? hasChronicDisease,
    bool? acceptedTerms,
  }) {
    return DonorModel(
      name: name ?? this.name,
      id: id ?? this.id,
      bloodType: bloodType ?? this.bloodType,
      donorId: donorId ?? this.donorId,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      hasChronicDisease: hasChronicDisease ?? this.hasChronicDisease,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
    );
  }

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
      hasChronicDisease: map['hasChronicDisease'] as bool,
      acceptedTerms: map['acceptedTerms'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory DonorModel.fromJson(String source) =>
      DonorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DonorModel(name: $name, id: $id, bloodType: $bloodType, donorId: $donorId, age: $age, gender: $gender, dob: $dob, bloodGroup: $bloodGroup, phone: $phone, email: $email, address: $address, city: $city, state: $state,hasChronicDisease: $hasChronicDisease, acceptedTerms: $acceptedTerms)';
  }

  @override
  bool operator ==(covariant DonorModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        other.bloodType == bloodType &&
        other.donorId == donorId &&
        other.age == age &&
        other.gender == gender &&
        other.dob == dob &&
        other.bloodGroup == bloodGroup &&
        other.phone == phone &&
        other.email == email &&
        other.address == address &&
        other.city == city &&
        other.state == state &&
        other.hasChronicDisease == hasChronicDisease &&
        other.acceptedTerms == acceptedTerms;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        bloodType.hashCode ^
        donorId.hashCode ^
        age.hashCode ^
        gender.hashCode ^
        dob.hashCode ^
        bloodGroup.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        address.hashCode ^
        city.hashCode ^
        state.hashCode ^
        hasChronicDisease.hashCode ^
        acceptedTerms.hashCode;
  }
}

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RequestModel {
  final String reqId;
  final String name;
  final String bloodGroup;
  final String phone;
  final String email;
  final String address;
  final String city;
  final String state;
  final String pinCode;
  final String bloodType;
  final DateTime date;
  RequestModel({
    required this.reqId,
    required this.name,
    required this.bloodGroup,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.bloodType,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reqId': reqId,
      'name': name,
      'bloodGroup': bloodGroup,
      'phone': phone,
      'email': email,
      'address': address,
      'city': city,
      'state': state,
      'pinCode': pinCode,
      'bloodType': bloodType,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      reqId: map['reqId'] as String,
      name: map['name'] as String,
      bloodGroup: map['bloodGroup'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      pinCode: map['pinCode'] as String,
      bloodType: map['bloodType'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestModel.fromJson(String source) =>
      RequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

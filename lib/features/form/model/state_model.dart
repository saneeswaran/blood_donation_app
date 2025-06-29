class StateDistrictModel {
  final String state;
  final List<String> districts;

  StateDistrictModel({required this.state, required this.districts});

  factory StateDistrictModel.fromMap(Map<String, dynamic> map) {
    return StateDistrictModel(
      state: map['state'],
      districts: List<String>.from(map['districts']),
    );
  }
}

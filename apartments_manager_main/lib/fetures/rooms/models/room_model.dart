import 'package:cloud_firestore/cloud_firestore.dart';

class ApartmentModel {
  final int apartmentNo, capacity, vacancy, rent;
  String? id;
  List<int> units;
  List<int> facilities;
  List<String> residents;

  ApartmentModel(
      {required this.apartmentNo,
      required this.capacity,
      required this.vacancy,
      required this.rent,
      required this.residents,
      required this.facilities,
      required this.units,
      this.id});

  Map<String, dynamic> toJson() {
    return {
      "ApartmentNo": apartmentNo,
      "Capacity": capacity,
      "Vacancy": vacancy,
      "Rent": rent,
      "Residents": residents,
      "Facilities": facilities,
      "Units": units,
    };
  }

  static ApartmentModel empty() => ApartmentModel(
      id: "",
      apartmentNo: 0,
      capacity: 0,
      vacancy: 0,
      rent: 0,
      facilities: <int>[],
      units: <int>[],
      residents: <String>[]);

  factory ApartmentModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ApartmentModel(
        id: document.id,
        apartmentNo: data["ApartmentNo"] ?? 0,
        capacity: data["Capacity: NoOfBedrooms"] ?? 0,
        vacancy: data['Vacancy'] ?? 0,
        rent: data['Rent'] ?? 0,
        residents:
            (data["Residents"] as List<dynamic>?)?.cast<String>() ?? <String>[],
        facilities:
            (data["Facilities"] as List<dynamic>?)?.cast<int>() ?? <int>[],
        units: (data["Units"] as List<dynamic>?)?.cast<int>() ?? <int>[],
      );
    } else {
      return ApartmentModel.empty();
    }
  }
}

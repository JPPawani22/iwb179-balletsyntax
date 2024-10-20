import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerModel {
  OwnerModel(
      {required this.id,
      required this.apartmentName,
      required this.address,
      required this.emailAddress,
      required this.mobileNumber,
      required this.ownwerName,
      required this.profilePictuer,
      required this.noOfunits,
      required this.noOfBedRooms,
      required this.noOfVacancy,
      required this.isAccountSetupCompleted});
  final String id;
  String ownwerName;
  String apartmentName;
  String address;
  final String emailAddress;
  final String mobileNumber;
  String profilePictuer;
  final int noOfunits;
  final int noOfBedRooms;
  final int noOfVacancy;
  final bool isAccountSetupCompleted;

  Map<String, dynamic> toJson() {
    return {
      'OwnerName': ownwerName,
      'HostelName': apartmentName,
      'Address': address,
      'EmailAddress': emailAddress,
      'MobileNumber': mobileNumber,
      'ProfilePictuer': profilePictuer,
      'NoOfRooms': noOfunits,
      'NoOfBeds': noOfBedRooms,
      'NoOfVacancy': noOfVacancy,
      'AccountSetupcompleted': isAccountSetupCompleted
    };
  }

  // factory model to create owner model from firebase document snapshort

  factory OwnerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return OwnerModel(
          id: document.id,
          apartmentName: data['ApartmentName'] ?? '',
          address: data['Address'] ?? '',
          emailAddress: data['EmailAddress'] ?? '',
          mobileNumber: data['MobileNumber'] ?? '',
          ownwerName: data['OwnerName'] ?? '',
          profilePictuer: data['ProfilePictuer'] ?? '',
          noOfunits: data['NoOfUnits'] ?? 0,
          noOfBedRooms: data['NoOfBedRooms'] ?? 0,
          noOfVacancy: data['NoOfVacancy'] ?? 0,
          isAccountSetupCompleted: data['AccountSetupcompleted'] ?? false);
    } else {
      return OwnerModel.empty();
    }
  }

  static OwnerModel empty() => OwnerModel(
      id: '',
      apartmentName: '',
      address: '',
      emailAddress: '',
      mobileNumber: '',
      ownwerName: '',
      profilePictuer: '',
      noOfunits: 0,
      noOfBedRooms: 0,
      noOfVacancy: 0,
      isAccountSetupCompleted: false);
}

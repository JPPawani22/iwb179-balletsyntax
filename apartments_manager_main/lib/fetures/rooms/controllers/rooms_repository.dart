// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:apartments_manager_main/fetures/rooms/models/room_model.dart';

class RoomsRepository with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

//------------------------------------------------------------------------------fetch Rooms

  Future<List<ApartmentModel>> fetchData() async {
    try {
      final userId = _auth.currentUser?.uid;

      if (userId == null || userId.isEmpty) {
        throw Exception("Unable to find user information, try again later");
      }

      final result =
          await _db.collection("Owners").doc(userId).collection("Rooms").get();

      final roomModels = result.docs
          .map((documentSnapshot) =>
              ApartmentModel.fromSnapshot(documentSnapshot))
          .toList();

      return roomModels;
    } catch (e) {
      print("Error: $e");

      rethrow;
    }
  }

  //----------------------------------------------------------------------------fetch single room

  Future<ApartmentModel?> fetchSingleRoom({required String roomId}) async {
    try {
      final userId = _auth.currentUser?.uid;

      if (userId == null || userId.isEmpty) {
        throw Exception("Unable to find user information, try again later");
      }

      final result = await _db
          .collection("Owners")
          .doc(userId)
          .collection("Rooms")
          .doc(roomId)
          .get();

      if (result.exists) {
        return ApartmentModel.fromSnapshot(result);
      }
    } catch (e) {
      print("Error: $e");

      rethrow;
    }
    return null;
  }

  Future<ApartmentModel?> getRoomByRoomNo(int roomNo) async {
    try {
      final userId = _auth.currentUser!.uid;
      final querySnapshot = await _db
          .collection("Owners")
          .doc(userId)
          .collection("Rooms")
          .where("RoomNo", isEqualTo: roomNo)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Room with the same number exists
        final roomData = querySnapshot.docs.first;
        return ApartmentModel.fromSnapshot(roomData);
      } else {
        // Room with the given number does not exist
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//------------------------------------------------------------------------------Add new Room

  addRoom(ApartmentModel room) async {
    try {
      final userId = _auth.currentUser!.uid;
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Rooms")
          .add(room.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  //----------------------------------------------------------------------------Update room

  Future<void> updadatRoom(ApartmentModel apartment) async {
    final userId = _auth.currentUser!.uid;
    try {
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Apartments")
          .doc(apartment.id)
          .update(apartment.toJson());
    } catch (e) {
      print("Something went wrong");
    }
  }

  //----------------------------------------------------------------------------update single field

  Future<void> updateSingleField(
      {required Map<String, dynamic> json, required String roomId}) async {
    try {
      final currentUser = _auth.currentUser;
      await _db
          .collection("Owners")
          .doc(currentUser!.uid)
          .collection("Apartments")
          .doc(roomId)
          .update(json);
    } catch (e) {
      print("Something went wrong");
      print(e);
    }
  }

  //--------------------------------------------------------------------------- Delete a room

  Future<void> deleteRoom(String roomId) async {
    try {
      final userId = _auth.currentUser!.uid;
      await _db
          .collection("Owners")
          .doc(userId)
          .collection("Rooms")
          .doc(roomId)
          .delete();
    } catch (e) {
      print("somthing went wrong");
    }
  }
}

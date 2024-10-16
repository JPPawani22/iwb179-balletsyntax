import 'package:flutter/material.dart';
import 'package:apartments_manager_main/fetures/bookings/screens/bookings_page.dart';
import 'package:apartments_manager_main/fetures/dashboard/screens/dashboard_page.dart';
import 'package:apartments_manager_main/fetures/residents/screens/residents_page.dart';
import 'package:apartments_manager_main/fetures/rooms/screens/rooms_page.dart';

class NavBarController with ChangeNotifier {
  int selectedIndex = 0;
  List<Widget> ownerPages = [
    const DashBoardPage(),
    const OwnerRoomsPage(),
    const BookingsPage(),
    const ResidentsPage(),
  ];

  void onNavTap(index) {
    selectedIndex = index;
    notifyListeners();
  }
}

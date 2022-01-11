import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindaaData {
  static bool isCustomer;
  static LatLng currentLatLng;
}

class User {
  String name;
  String mobileNo;
  String pin;
  bool isCustomer;
  User(this.name, this.mobileNo, this.pin, this.isCustomer);
}

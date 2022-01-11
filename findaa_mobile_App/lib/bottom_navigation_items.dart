import 'package:flutter/material.dart';

class BottomNaviagationItems {
  var customerHomeBottomNavigationItems = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        size: 40,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add_circle,
        color: Colors.orange,
        size: 40,
      ),
      label: 'add',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        size: 40,
      ),
      label: 'Profile',
    ),
  ];
}

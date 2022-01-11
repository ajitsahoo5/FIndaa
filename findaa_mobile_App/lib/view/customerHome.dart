import 'package:findaa/presenter/data.dart';
import 'package:findaa/view/business_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bottom_navigation_items.dart';
import 'drawer.dart';

class CustomerHome extends StatefulWidget {
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  int _selectedIndex = 0;
  List<String> businessNames = [
    'ATM',
    'Education',
    'Food',
    'Health',
    'Beauty',
    'Logistics',
    'Offices',
    'Wellness',
    'Printing',
    'Banks',
    'Event Management',
    'Repair',
    'Any Thing on Hire',
    'Public Toilet',
    'Pet Care',
    'Auto care',
    'Home Décor',
    'Legal Services'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.orange,
            size: 40,
          ),
          title: Text(
            'Welcome to Findaa',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
              child: Image.asset(
                "images/logo2.png",
                height: 35,
                width: 35,
              ),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 100,
        ),
        preferredSize: Size.fromHeight(100.0),
      ),
      drawer: AppDrawer(),
      body: AnnotatedRegion(
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildLocationFields(),
                    SizedBox(height: 10),
                    buildButtonField(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 25, 0, 0),
                      child: Text(
                        'Search By Category',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Flexible(
                      child: buildBusinessGrid(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        value: SystemUiOverlayStyle.light,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: BottomNaviagationItems().customerHomeBottomNavigationItems,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildLocationFields() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orange[900],
            Colors.orange,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 45,
              child: TextField(
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.orange[900],
                  ),
                  hintText: "City",
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 45,
              child: TextField(
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Colors.orange[900],
                  ),
                  hintText: "Search by business",
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
      child: Center(
        child: ButtonTheme(
          minWidth: double.infinity,
          child: OutlineButton(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                'VIEW BEST DEALS',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.orange,
                ),
              ),
            ),
            borderSide: BorderSide(
              color: Colors.orange,
              style: BorderStyle.solid,
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () => {},
          ),
        ),
      ),
    );
  }

  Widget buildBusinessGrid() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: List.generate(
        businessNames.length,
        (index) =>
            buildGridItem(businessNames[index], "images/business_shop.png"),
      ),
    );
  }

  Widget buildGridItem(String name, String image) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black38,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              image,
              height: 45,
              width: 45,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BusinessList(name),
          ),
        );
      },
    );
  }
}

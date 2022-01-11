import 'package:findaa/view/selected_business.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BusinessList extends StatefulWidget {
  String businessCategory;
  BusinessList(this.businessCategory);

  @override
  _BusinessListState createState() => _BusinessListState(businessCategory);
}

class _BusinessListState extends State<BusinessList> {
  String category;
  _BusinessListState(this.category);
  double _range = 10.0;
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
            category,
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
          toolbarHeight: 60,
        ),
        preferredSize: Size.fromHeight(65.0),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 100,
                child: Flexible(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (_, index) => _createCard(),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                height: 40,
                child: Slider(
                  value: _range,
                  min: 0.0,
                  max: 10.0,
                  activeColor: Colors.orange,
                  label: _range.toString(),
                  onChanged: (double value) {
                    setState(() {
                      _range = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createCard() {
    return Container(
      child: InkWell(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "images/business_shop.png",
                  height: 100,
                  width: 100,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name of the Business",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          rating: 4.2,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 24.0,
                          unratedColor: Colors.amber.withAlpha(50),
                          direction: Axis.horizontal,
                        ),
                        Text(
                          '4.2/5',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '(100 Ratings)',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Closed',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          ' - open at 10:00AM',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.orange,
                        ),
                        Text(
                          'MAP',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Icon(
                          Icons.call_rounded,
                          color: Colors.orange,
                        ),
                        Text(
                          ' CONTACT',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Business("Business Name"),
            ),
          );
        },
      ),
    );
  }
}

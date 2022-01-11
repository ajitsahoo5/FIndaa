import 'dart:io';

import 'package:findaa/View/drawer.dart';
import 'package:findaa/presenter/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class BusinessOwnerHome extends StatefulWidget {
  @override
  _BusinessOwnerHomeState createState() => _BusinessOwnerHomeState();
}

class _BusinessOwnerHomeState extends State<BusinessOwnerHome> {
  CameraPosition initialCameraPosition = CameraPosition(
    target: FindaaData.currentLatLng,
    zoom: 17.0,
  );

  GoogleMapController _controller;
  List<Marker> markerList = [];

  PickedFile _image1;
  PickedFile _image2;
  PickedFile _image3;

  ImagePicker _imagePicker = ImagePicker();

  //Get image from camera or Gallery
  _imageFromCamera() async {
    PickedFile image = await _imagePicker.getImage(
      source: ImageSource.camera,
    );
    setState(() {
      if (_image1 == null) {
        _image1 = image;
      } else if (_image2 == null) {
        _image2 = image;
      } else if (_image3 == null) {
        _image3 = image;
      }
    });
  }

  _imageFromGallery() async {
    PickedFile image = await _imagePicker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (_image1 == null) {
        _image1 = image;
      } else if (_image2 == null) {
        _image2 = image;
      } else if (_image3 == null) {
        _image3 = image;
      }
    });
  }

  removeImage(PickedFile file) {
    setState(() {
      if (_image1 == file) {
        _image1 = _image2;
        _image2 = _image3;
        _image3 = null;
      } else if (_image2 == file) {
        _image2 = _image3;
        _image3 = null;
      } else if (_image3 == file) {
        _image3 = null;
      }
    });
  }

  _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library_outlined),
                  title: Text('Gallery'),
                  onTap: () {
                    _imageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera_outlined),
                  title: Text('Camera'),
                  onTap: () {
                    _imageFromCamera();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildImage(PickedFile file) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black38),
            ),
            child: Image(
              image: FileImage(
                File(
                  file.path,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0.0,
          child: GestureDetector(
            onTap: () {
              removeImage(file);
            },
            child: Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.close_sharp,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ),
        )
      ],
    );
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
            "Dear Business Owner\nWelcome to Findaa",
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
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildInfo(),
                      addBusinessForm(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        value: SystemUiOverlayStyle.light,
      ),
    );
  }

  Widget buildInfo() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orangeAccent[400],
                Colors.white,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "images/business_shop.png",
                height: 90,
                width: 90,
              ),
              Text(
                "Please enter few more details of\nyour business",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget addBusinessForm() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Location on Map",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black38,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: initialCameraPosition,
                  markers: markerList.toSet(),
                  onMapCreated: (controller) {
                    setState(() {
                      markerList.add(
                        Marker(
                          position: FindaaData.currentLatLng,
                          markerId: MarkerId('Your Location'),
                        ),
                      );
                      _controller = controller;
                    });
                  },
                  onTap: (coordinates) {
                    _controller.animateCamera(
                      CameraUpdate.newLatLng(coordinates),
                    );
                    markerList.removeLast();
                    markerList.add(
                      Marker(
                        position: coordinates,
                        markerId: MarkerId(
                            '${coordinates.latitude}-${coordinates.longitude}'),
                      ),
                    );
                    setState(() {});
                  }),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            child: TextField(
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.phone_android_outlined,
                  color: Colors.orange[900],
                ),
                hintText: "Name of Shop/Business",
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            child: TextField(
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.orange[900],
                ),
                hintText: "Address",
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            child: TextField(
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.phone_rounded,
                  color: Colors.orange[900],
                ),
                hintText: "Contact Number",
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Add image of your shop",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 110,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black38,
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 20),
                  InkWell(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black38),
                      ),
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 40,
                        color: Colors.black38,
                      ),
                    ),
                    onTap: () {
                      _showPicker();
                    },
                  ),
                  _image1 == null ? Container() : buildImage(_image1),
                  _image2 == null ? Container() : buildImage(_image2),
                  _image3 == null ? Container() : buildImage(_image3),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                primary: Colors.orange[800],
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                "SUBMIT",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
